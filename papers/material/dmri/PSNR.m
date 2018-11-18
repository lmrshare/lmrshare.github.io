function psnr = PSNR(truth,y)
[aa,bb] = size(truth);
psnr=20*log10(sqrt(aa*bb)/norm(double(abs(y))-double(abs(truth)),'fro'));