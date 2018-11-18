function [W] = blockmatch(xk, xk_1, L)

W=zeros(length(xk));

for center=(L+1):(2*L+1):(length(xk)-L)
    blk=xk((center-L):(center+L));
    idx=0;
    for c=(center-L):(center+L)
        idx = idx + 1;
        if c <= L || c > (length(xk)-L)
            mad(idx)=inf;
            continue;
        end
        blk_1=xk_1((c-L):(c+L));
        mad(idx)=sum(abs(blk-blk_1));
%        mad(idx) = norm(blk-blk_1);
    end
    [~, idx]=min(mad);
    pos = idx+center-L-1;
    for i=0:(2*L)
        W(center-L+i, pos-L+i)=1;
    end
end

%{
clear err
t=1;
for L=1:10
    W=motion(foo(:, t+1), foo(:, t), L);
    err(L)=norm(foo(:, t+1) -  W*foo(:, t));
end
plot(err, '.-')
for L=1:10
    err(L)=norm(foo(:, t+1) -  foo(:, t));
end
hold on 
plot(err, '.-r');


L=3;
figure;imshow(abs(truth(:, :, t+1)-truth(:, :, t)));colormap(hot)
for i = 1:256
    W=motion(squeeze(truth(:, i, t+1)), squeeze(truth(:, i, t)), L);
    me(:, i, t+1)=W*truth(:, i, t);
end
figure;imshow(abs(me(:, :, t+1)-truth(:, :, t)));colormap(hot)
%}

