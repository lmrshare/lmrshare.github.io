---
layout: post
title: "MRI传统方法总结"
date: 2015-06-01
description: "traditional methods"
tag: Research
---

### 目录

* [SENSE](#sense)
* [RIGR](#rigr)
* [待梳理](#will-review)
* [Reference](#reference)

### <a name="sense"></a>[SENSE](#reference)

#### 理论:

&emsp;&emsp;SENSE成像由两部构成, __第一步:__ 预采样以得到所有相控阵线圈的低分辨率全FOV 图像$S_i, i \in $ { $1, 2,..., N_c $ }, 然后利用下面公式得到每个线圈敏感度的估计:

$$
C_j(x, y) = \frac{S_j(x, y)}{\sqrt{\sum_{j=1}^{N_c}S_j(x, y)^2}}
\tag{1}
$$

分母为各个线圈得到的地分辨率全FOV图像的均方. __第二步:__ 利用所有线圈采集到的部分 __k__ 空间数据和线圈敏感度打开重叠的图像.

&emsp;&emsp;下面对第二步详细说明: 以第 __i__ 个线圈为例, 假设全采样 __k__ 空间数据 __K__ 规模为$NxN$, 当进行欠采样后, 相控阵线圈得到的 __k__ 空间数据$SK_i$规模为:$\frac{N}{R} x N$(1D 采样)或者$\frac{N}{R} x \frac{N}{R}$(2D 采样), 其中$R$为降采样因子. 直接对$SK_i$进行二维逆傅立叶变换后得到有叠影的空间域图像$A_i$, SENSE的思路就是找
到各个叠影图像与目标图像$I$的数学关系, 从$A_i$与$Sk_i$的数学关系开始推导如下:

$$
\begin{eqnarray*}
A_i(u, v) & = & \frac{R}{N^2}\sum_{x=0}^{\frac{N}{R}-1}\sum_{y=0}^{N-1}SK_i(x, y)e^{2\pi j(\frac{ux}{\frac{N}{R}} + \frac{vy}{N})} \\
          & = & \frac{R}{N^2}\sum_{x=0}^{\frac{N}{R}-1}\sum_{y=0}^{N-1}K(Rx-(R-1), y)e^{2\pi j w(x, y)} \\
          & = & Re^{2\pi j\frac{u(R-1)}{N}}(\frac{1}{N^2}\sum_{x=0}^{N}\sum_{y=0}^{N-1}K(x, y)S(x, y)e^{2\pi j w(x, y)})\\
\end{eqnarray*}
$$

其中, $w(x, y) = \frac{u(Rx - (R-1) + (R+1))}{N} + \frac{vy}{N}$. 由上式最终可得:

$$
A_i(u, v) = Re^{2\pi j\frac{u(R-1)}{N}}(F^{-1}(S)*(C_i I))
\tag{2}
$$

其中$S$ 为采样矩阵, 这样我们就得到了叠影图像值与理想图像值的关系, 最终就是解决如下的方程组:

$$
\begin{bmatrix}
E_1(i,j) &E_1(i+\frac{N}{R},j)  &\cdot \cdot \cdot   &E_1(i+\frac{N}{R}(R-1),j) \\ 
E_2(i,j) &E_2(i+\frac{N}{R},j)  &\cdot \cdot \cdot   &E_2(i+\frac{N}{R}(R-1),j) \\ 
\cdot    &\cdot                 &\quad               &\cdot    \\ 
\cdot    &\cdot                 &\cdot               &\cdot    \\ 
\cdot    &\cdot                 &\quad               &\cdot    \\ 
E_{N_c}(i,j) &E_{N_c}(i+\frac{N}{R},j)  &\cdot \cdot \cdot   &E_{N_c}(i+\frac{N}{R}(R-1),j) \\ 
\end{bmatrix}
\cdot
\begin{bmatrix}
I(i, j) \\
I(i+\frac{N}{R}, j) \\
\cdot \\
\cdot \\
\cdot \\
I(i+\frac{N}{R}(R-1), j)
\end{bmatrix}
=
\begin{bmatrix}
A_1(i, j) \\
A_2(i, j) \\
\cdot \\
\cdot \\
\cdot \\
A_{N_c}(i, j)
\end{bmatrix}

\tag{3}
$$

简写为:

$$
EI(i:\frac{N}{R}:(i + \frac{N}{R}(R-1)), j) = A_{1:N_c}(i, j)
\tag{4}
$$
这是一个最小二乘问题:

$$
F = (E^H E)^{-1}E^H
$$

最终结果为:

$$
I = FA_{1:N_c}(i, j)
$$

迭代每个$A_{1:N_c}(u, v)$, 最终可得到目标图像$I$. 对于2D采样, 分析过程和1D一样.

#### Matlab代码:

```

function [I,C] = sense(S,k,Sampling)
%
%SENSE: Reconstruction of subsampled data using SENSE
%
% INPUTS:
%       S: low resolution image (size: N x N x Nc; Nc:The number of coils) 
%       k: k-space ;size(N x N x Nc)
%       Sampling: sample matrix
%
% OUTPUT
%	I: Reconstructed image
%-------------------------------------------------------------
[m,n,Nc] = size(S);
C = zeros(m,n,Nc);

% 1.estimate the coil sensitivity
%ref = sqrt(sum(S.*conj(S),3));
%ref = sum(abs(S),3);
ref = sum(abs(S),3);
ref(find(ref==0)) = 1;
for i = 1:Nc
    tmp = abs(S(:,:,i))./ref;
    tmp(find(ref==0)) = 1/Nc;
    C(:,:,i) = tmp; 
end

% obtain the Sk(subsampled k-space;1D or 2D subsampled);
dimension = 1; 

% phase encoding
G = Msp(Sampling(:,1));
R = m/size(G,1);
Sk = [];
for i = 1:Nc 
    Sk(:,:,i) = G * k(:,:,i);
end

% frequency encoding
G = Msp(Sampling(1,:));
if size(G,1)>0 && size(G,1) < m
    dimension = 2;
    tmp = [];
    for i = 1:Nc
        tmp = Sk(:,:,i) * G';
    end
    Sk = tmp;
end

%2.remove aliasing
A = zeros(size(Sk));
for i = 1:Nc
    %A(:,:,i) = ifft2(Sk(:,:,i));
    A(:,:,i) = ifft2(fftshift(fftshift(Sk(:,:,i),1),2));
end
if dimension ==1
    %for i = 1:size(A,1)
    %    A(i,:,:) = A(i,:,:)/exp(2*pi*i*(R-1)/n*1j);
    %end
    I = zeros(m,n);
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            %E = squeeze(C(i:size(A,1):(size(A,1)*(R-1)+i),j,:))' * (1/R);
            step = size(A,1);
            E = squeeze(C(i:step:end,j,:))' + repmat(eye(R),Nc/R,1); 
            F = inv(E'*E)*E';
            I(i:step:end,j) = F * (squeeze(A(i,j,:)) + repmat(ref(i:step:end,j),Nc/R,1));   
        end 
    end
else
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            A(i,j,:) = A(i,:,:)/(R*R*exp(2*pi*(i+j)*(R-1)/n*1j));
        end
    end
    I = zeros(m,n);
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            step = size(A,1);
            tmp = C(i:step:(step*(R-1)+i),j:step:(step*(R-1)+j),:);
            E = squeeze(reshape(tmp,size(A,1)*size(A,1),1,Nc))'*(1/R^2);
            F = inv(E'*E)*E';
            I(i:size(A,1):(size(A,1)*(R-1)+i),j:size(A,1):(size(A,1)*(R-1)+j)) = reshape(F * squeeze(A(i,j,:))',R,R);
        end
    end
end

```

### <a name="rigr"></a>[RIGR](#reference)

#### 理论:

&emsp;&emsp;RIGR是一种动态磁共振成像算法, 理论上, RIGR利用了K空间数据的相关性来重建图像. RIGR假设目标图像可以通过傅立叶基表示(generalized series, GS). 假设第一帧是全采样$[0, N-1]x[0, M-1]$, 其余帧进行下采样, 为$N_u x [0, M-1]$. 假设k空间的每一帧是全采样的, 那么$f(i, k)$可以通过inverse DFT重建:

$$
f(i, k)=\frac{1}{N}\sum_{n=0}^{N-1}exp(2 \pi j \frac{ni}{N})\frac{1}{M}\sum_{m=0}^{M-1}F(n,m)exp(2 \pi j \frac{mk}{M})
\tag{1}
$$

现仅考虑采样数据$N_u$, 我们通过GS表示图像:

$$
\hat{f}(i,k)=\frac{1}{N}S(i,k)\sum_{t \in N_u} exp(2 \pi j\frac{ti}{N}) c_{t,k}
\tag{2}
$$

其中, $c_{t, k}$是GS的系数(通过Toeplitz 系统求得), $S(i, k)$涵有prior information. 通过计算$\hat{f}(i, k)$的DFT, 我们有:

$$
\hat{F}(n, m)=\sum_{i=0}^{N-1}\sum_{k=0}^{M-1}\hat{f}(i,k)exp(-2 \pi j(\frac{ni}{N}+\frac{mk}{M}))
\tag{3}
$$

将$(2)$带入$(3)$有:

$$

\begin{eqnarray*}
\hat{F}(n, m) & = & \frac{1}{N}\sum_{i=0}^{N-1}\sum_{k=0}^{M-1} S(i,k)\sum_{t \in N_u} exp(2 \pi j \frac{ti}{N}) c_{t,k} exp(-2 \pi j(\frac{ni}{N}+\frac{mk}{M})) \\
              & = & \frac{1}{N}\sum_{k=0}^{M-1}exp(-2 \pi j\frac{mk}{M})\sum_{t \in N_u}c_{t,k} (\sum_{i=0}^{N-1}S(i,k)exp(-2 \pi j\frac{n-t}{N}i))
\end{eqnarray*}
$$

其中, $n \in N_u$, $m = [0, M-1]$. 由上式可得:

$$
\frac{1}{N} \sum_{t \in N_u}c_{t,k} (\sum_{i=0}^{N-1}S(i,k)exp(-2 \pi j\frac{n-t}{N}i))=\frac{1}{M} \sum_{m=0}^{M-1}\hat{F}(n,m)exp(2 \pi j \frac{mk}{M})
\tag{4}
$$

其中, $n \in N_u$, $k = [0, M-1]$. 对于每个固定的$k$, $(4)$都是一个Toeplitz系统, 进而通过解这个系统得到$c_{t, k}(t \in N_u)$.(ps: 该系数同于$(2)$). 通常, $S(i, k)$ 为$I_0 (i, k)$, $i = [0, N-1]$, $k = [0, M-1]$.

#### Matlab代码:

```
function img=rigr(K0, K)

[N, M]=size(K0);

S=abs(ifft2(ifftshift(K0)));
I=find(sum(abs(K), 2)>0);

B=ifft(K(I, :), [], 2);
tmp=repmat(I-1, 1, length(I));

for i=1:N
    T(:, :, i) = exp(-2*pi*1j*(tmp-tmp')*(i-1)/N);
end
for k=1:M
    A=zeros(length(I));
    for i=1:N
        A = A + T(:, :, i)*S(i, k);
    end
    A = A / N;
    C(:, k) = A \ B(:, k);
end

tmp=(1:N)'-1;
img=zeros(N, M);
for m=1:length(I)
    img = img + exp(2*pi*1j*tmp*(I(m)-1)/N)*C(m, :);
end
img = (img.*S)/N;

```
### <a name="will-review"></a>待梳理

+ <font color="ff0000">UNFOLD</font>
+ <font color="ff0000">kt-BLAST、kt-PCA</font>

### <a name="reference"></a>Reference

- [1. SENSE: sensitivity encoding for fast MRI](https://www.ncbi.nlm.nih.gov/pubmed/10542355)
- [2. RIGR: A generalized series approach to MR spectroscopic imaging](https://www.ncbi.nlm.nih.gov/pubmed/18222809)

<br>

转载请注明：[Mengranlin](https://lmrshare.github.io) » [点击阅读原文](https://lmrshare.github.io/2015/09/iOS9_Note/)
