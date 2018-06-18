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