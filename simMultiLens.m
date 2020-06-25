clear all; close all; clc;

global pixelSize;
global propDis;
global lambda;
global numLambda;
global n_Poly;
global k_Poly;

global designHeight;
global imageComplex;
global transferFunc;
global RefIndex;
global kvec;

nm = single(1e-009);
um = single(1e-006);
mm = single(1e-003);

pixelSize = 10 * um;
propDis = 50 * mm;
lambda = [405, 532, 633] * nm;
numLambda = length(lambda);
n_Poly = single([1.6894, 1.6482, 1.6347] );
k_Poly = single(zeros(size(n_Poly)));
kvec = 2 * pi ./ lambda;

designHeight = importdata('designHeight.mat');

[numPixelYPadded, numPixelXPadded] = size(designHeight);
sizeXPadded = pixelSize * numPixelXPadded;
sizeYPadded = pixelSize * numPixelYPadded;

RefIndex = n_Poly + 1i * k_Poly;

du = 1 / sizeXPadded;
umax = 1 / (2 * pixelSize);
u = (-umax + du / 2) : du : (umax - du / 2);
[U] = meshgrid(u);
U = sqrt((U.^2) + ((U').^2 ) );

for ww = 1: numLambda
    u_ev = 1 / lambda(ww);
    u_np = u_ev * (sizeXPadded / 2 / propDis);
    u_cut = min(u_ev, u_np);
    Wb = U < u_cut;
    
    transferFunc{ww} = exp(1i * 2 * pi * propDis / lambda(ww) ) .* exp((-1i * pi * lambda(ww) * propDis) .* (U .^ 2));
    transferFunc{ww} = transferFunc{ww} .* Wb;
    phi{ww} = (2 * pi * (RefIndex(ww) - 1) / lambda(ww) ) .* designHeight;
    Transmission{ww} = exp(1i .* phi{ww});
    imageComplex{ww} = ifft2(ifftshift( fftshift(fft2(Transmission{ww})) .* transferFunc{ww} ));
end

red  = double(abs(imageComplex{3}) .^ 2);
green  = double(abs(imageComplex{2}) .^ 2);
blue  = double(abs(imageComplex{1}) .^ 2);
a = zeros(size(red));
just_red = cat(3, red, a, a);
just_green = cat(3, a, green, a);
just_blue = cat(3, a, a, blue);
figure, imshow(just_red), title('Red channel')
figure, imshow(just_green), title('Green channel')
figure, imshow(just_blue), title('Blue channel')