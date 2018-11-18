function kt=dphantom(Noise)

imagesize = 128;
ROsize = imagesize;
PEsize = imagesize;
nimage = 40;
TE = 0.005;
%Noise = 1e-5;

More.ras = imagesize/16;
More.ral = imagesize/8;
More.om = 1/2;
More.ams = imagesize/64;
More.aml = imagesize/32;
More.center = [3*imagesize/4 5*imagesize/8];
More.values = [0 1 2];
More.imsize = 128;

Less = More;
Less.om = 1/8;
Less.center = [imagesize/2 3*imagesize/8];

Static = More;
Static.om = 0;
Static.center = [imagesize/4 imagesize/4];

StaticIM = getIM(Static,0,0);

kt = zeros(ROsize,PEsize, nimage);
for im = 1:nimage,
    for pe = 1:PEsize,
        rawimage = getIM(More,TE,pe+(im-1)*PEsize)+getIM(Less,TE,pe+(im-1)*PEsize)+StaticIM;
        kdata = ifft2(rawimage)+Noise/sqrt(2)*randn(imagesize)+1i*Noise/sqrt(2)*randn(imagesize);
        kt(:, pe, im)=kdata(:, pe);
    end
end
