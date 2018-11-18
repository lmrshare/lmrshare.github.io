% Y:kt空间数据
% M:采样三维矩阵
% lx:存储待重建的列号
% X：空间域-t数据
function X=particle(Y, M, lx)

[m,n,k] = size(Y);  
N = 1000;%N为粒子的个数

Y = ifft(Y,[],2);
Y = Y.*M;             %部分kt数据

if nargin <3 || isempty(lx)
    lx = 1:n;
end

tic;
X=zeros(size(Y));
%处理所有帧中lx
for i = 1:length(lx)  
    x = lx(i);
    x0 = cs(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, 1)));
    x0 = x0/max(abs(x0(:)));
    X(:,x,1) = x0;
    
    %初始化粒子以及W
    x_part = [];
    W = [];
    for j = 1:N
        x_part = [x_part,x0];
        W = [W,1/N];
    end
    %对k帧的信号进行估计
    for l = 2:k
        R = [];
        for s = 1:N
            R = [R,distribution(m,x)]; 
        end
                            %预测第l（字母l，不是1）帧粒子
         CS = cs(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, l)));
         CS = CS/max(abs(CS));
         CS = repmat(CS,1,N);
         x_part = x_part + CS;
         x_part = x_part/max(abs(x_part(:))) + R;
                            %更新权值W
         %更新权值W，权值的更新重点在于对似然概率密度P(yk|x(k)i)的估计,yk是k帧的部分观测值
         %x(k)i代表第i个粒子，该密度体现的是粒子和观测值之间的关系，为了反映该关系，我对
         %P(yk|x(k)i)的估计思想为：与yk越接近，那么粒子与yk的关系越紧密，对应的似然密度越大
         %接下来的问题就是：如何衡量与yk 的接近程度。
         %我的方案是：对粒子进行傅立叶变换（非部分傅立叶变换），得到信息z_esti；取得Y(：,x,l)
         %的非零部分信息z（非零部分信息就是yk）;error = exp(abs((abs(z) - abs(z_esti))).^2)
         %然后error的倒数就是我对P的描述函数。
         
         
         G = Msp(squeeze(M(:, x, l)));
         z = G * squeeze(Y(:, x, l));   %取得观测信号（即Y(:,x,l)的非零部分）
         z = repmat(z/max(abs(z)),1,N);             %组织称矩阵
         z_esti = G * fft(x_part,[],1); %获得与Y(:,x,l)的非零部分所对应的位置相同的粒子的值
         z_esti = z_esti / max(abs(z_esti(:)));
         error = abs((abs(z) - abs(z_esti))).^2;%不一定非用指数函数
         P = 1./mean(error,1);%P是对似然概率密度的估计,不一定非用mean函数
         P = P/sum(P);
         W = W.*P; 
         W = W/sum(W);     
         
         %估计l帧信息
         X(:,x,l) = x_part * W';%将信号保存
            
         %多项式重采样来更新粒子
         tmp = x_part;
         for s = 1:N
             u = rand; 
             qsum = 0;
             for o = 1 : N
                 qsum = qsum + W(o);
                 if qsum >= u
                     x_part(:,s) = tmp(:,o);
                     break;
                 end
             end
         end %重采样结束
    end%对k帧信号处理完毕
end%处理所有帧中lx列完毕
tElapsed=toc;
disp(['particle_2: ' num2str(tElapsed)]);
end%m文件结束