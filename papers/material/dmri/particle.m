% Y:kt�ռ�����
% M:������ά����
% lx:�洢���ؽ����к�
% X���ռ���-t����
function X=particle(Y, M, lx)

[m,n,k] = size(Y);  
N = 1000;%NΪ���ӵĸ���

Y = ifft(Y,[],2);
Y = Y.*M;             %����kt����

if nargin <3 || isempty(lx)
    lx = 1:n;
end

tic;
X=zeros(size(Y));
%��������֡��lx
for i = 1:length(lx)  
    x = lx(i);
    x0 = cs(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, 1)));
    x0 = x0/max(abs(x0(:)));
    X(:,x,1) = x0;
    
    %��ʼ�������Լ�W
    x_part = [];
    W = [];
    for j = 1:N
        x_part = [x_part,x0];
        W = [W,1/N];
    end
    %��k֡���źŽ��й���
    for l = 2:k
        R = [];
        for s = 1:N
            R = [R,distribution(m,x)]; 
        end
                            %Ԥ���l����ĸl������1��֡����
         CS = cs(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, l)));
         CS = CS/max(abs(CS));
         CS = repmat(CS,1,N);
         x_part = x_part + CS;
         x_part = x_part/max(abs(x_part(:))) + R;
                            %����ȨֵW
         %����ȨֵW��Ȩֵ�ĸ����ص����ڶ���Ȼ�����ܶ�P(yk|x(k)i)�Ĺ���,yk��k֡�Ĳ��ֹ۲�ֵ
         %x(k)i�����i�����ӣ����ܶ����ֵ������Ӻ͹۲�ֵ֮��Ĺ�ϵ��Ϊ�˷�ӳ�ù�ϵ���Ҷ�
         %P(yk|x(k)i)�Ĺ���˼��Ϊ����ykԽ�ӽ�����ô������yk�Ĺ�ϵԽ���ܣ���Ӧ����Ȼ�ܶ�Խ��
         %��������������ǣ���κ�����yk �Ľӽ��̶ȡ�
         %�ҵķ����ǣ������ӽ��и���Ҷ�任���ǲ��ָ���Ҷ�任�����õ���Ϣz_esti��ȡ��Y(��,x,l)
         %�ķ��㲿����Ϣz�����㲿����Ϣ����yk��;error = exp(abs((abs(z) - abs(z_esti))).^2)
         %Ȼ��error�ĵ��������Ҷ�P������������
         
         
         G = Msp(squeeze(M(:, x, l)));
         z = G * squeeze(Y(:, x, l));   %ȡ�ù۲��źţ���Y(:,x,l)�ķ��㲿�֣�
         z = repmat(z/max(abs(z)),1,N);             %��֯�ƾ���
         z_esti = G * fft(x_part,[],1); %�����Y(:,x,l)�ķ��㲿������Ӧ��λ����ͬ�����ӵ�ֵ
         z_esti = z_esti / max(abs(z_esti(:)));
         error = abs((abs(z) - abs(z_esti))).^2;%��һ������ָ������
         P = 1./mean(error,1);%P�Ƕ���Ȼ�����ܶȵĹ���,��һ������mean����
         P = P/sum(P);
         W = W.*P; 
         W = W/sum(W);     
         
         %����l֡��Ϣ
         X(:,x,l) = x_part * W';%���źű���
            
         %����ʽ�ز�������������
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
         end %�ز�������
    end%��k֡�źŴ������
end%��������֡��lx�����
tElapsed=toc;
disp(['particle_2: ' num2str(tElapsed)]);
end%m�ļ�����