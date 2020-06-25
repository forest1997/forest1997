clc;
clear;
n=1;
theta=pi/2;
phi=0;
temp0=20;
kx=1;
ky=0;
kz=0;
        
        
for Lambda=1.0:0.001:1.7;
    lambda2=Lambda/2;
    for temp=0:0.1:200;


nxw=sqrt(2.4542+0.01125/(Lambda^2-0.01135)-0.01388*Lambda^2); %p是e光
nyw=sqrt(2.5390+0.01277/(Lambda^2-0.01189)-0.01849*Lambda^2);
nzw=sqrt(2.5865+0.01310/(Lambda^2-0.01223)-0.01862*Lambda^2);
nxw2=sqrt(2.4542+0.01125/(lambda2^2-0.01135)-0.01388*lambda2^2);     %o光
nyw2=sqrt(2.5390+0.01277/(lambda2^2-0.01189)-0.01849*lambda2^2);
nzw2=sqrt(2.5865+0.01310/(lambda2^2-0.01223)-0.01862*lambda2^2);

%室温下，快慢光的折射率
deltatemp=temp-temp0;%温度差
deltanxw=(-3.76*Lambda+2.30)*10^-6*(deltatemp+29.13*10^-3*deltatemp^2);
deltanyw=(6.01*Lambda-19.40)*10^-6*(deltatemp-32.89*10^-4*deltatemp^2);
deltanzw=(1.50*Lambda-9.70)*10^-6*(deltatemp-74.49*10^-4*deltatemp^2);
deltanxw2=(-3.76*lambda2+2.30)*10^-6*(deltatemp+29.13*10^-3*deltatemp^2);
deltanyw2=(6.01*lambda2-19.40)*10^-6*(deltatemp-32.89*10^-4*deltatemp^2);
deltanzw2=(1.50*lambda2-9.70)*10^-6*(deltatemp-74.49*10^-4*deltatemp^2);

%温度变化后，快慢光的折射率
nx=nxw+deltanxw;
ny=nyw+deltanyw;
nz=nzw+deltanzw;
nxw=nxw2+deltanxw2;
nyw=nyw2+deltanyw2;
nzw=nzw2+deltanzw2;

a=1/nx^2;
b=1/ny^2;
c=1/nz^2;
a1=1/nxw^2;
b1=1/nyw^2;
c1=1/nzw^2;
    
B=-kx^2*(b+c)-ky^2*(a+c)-kz^2*(a+b);
C=kx^2*b*c+ky^2*a*c+kz^2*a*b;
B1=-kx^2*(b1+c1)-ky^2*(a1+c1)-kz^2*(a1+b1);
C1=kx^2*b1*c1+ky^2*a1*c1+kz^2*a1*b1;
%B2=-kx^2*(b2+c2)-ky^2*(a2+c2)-kz^2*(a2+b2);
%C2=kx^2*b2*c2+ky^2*a2*c2+kz^2*a2*b2;
n1=sqrt(2/(-B-sqrt(B^2-4*C)));
%nw1=sqrt(2/(-B1-sqrt(B1^2-4*C1)));
nw2=sqrt(2/(-B1+sqrt(B1^2-4*C1)));


yy(n)=2*n1/Lambda-nw2/lambda2;
      if abs(yy(n))<0.000001
            y(n)=temp;
            x(n)=Lambda;
            n=n+1; 
      end
      
    end
end


plot(x,y);
























