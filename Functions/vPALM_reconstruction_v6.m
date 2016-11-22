function [PALM_image,ycoor,xcoor,Imax] = vPALM_reconstruction_v6(X, Y, s, A, ps, border, Pixel_to_photon,uniform_peaks, max_intensity, hot, logyes)

% Keep in mind that X and Y are definied as the two axis of a cartesian
% referencial. For the image, you need to switch from this cartesian
% notation to a matricial one using rows and columns. In that case, remember that X is related to 
% columns and Height-Y to the rows.

% X is projected coordinates along X
% Y is projected coordinates along Y
% s is localization precision
% ps is the output pixel size in nm
% border is 

N = size(X,2);% N = 1000;
overflowed = find(A>max_intensity); % Look for all the events that display an intensity greater than max_intensity
A(overflowed) = max_intensity; % Allow us to control the contrast of the image

Xmin = min(X);
Ymin = min(Y);
Xmax = max(X);
Ymax = max(Y);

X=X-Xmin;
Y=Y-Ymin;
% The size of the pixel is defined by 'ps' and its default value is set at 5nm=5e-3?m. 

xx1 = floor(Xmin/ps)*ps:ps:ceil(Xmax/ps)*ps;
xxcenters = xx1(1)+ps/2:ps:xx1(end)-ps/2;
yy1 = floor(Ymin/ps)*ps:ps:ceil(Ymax/ps)*ps;
yycenters = yy1(1)+ps/2:ps:yy1(end)-ps/2;

imsize_half=5;
imsize=imsize_half*2+1;
Nx = round (((Xmax+imsize_half+border) )/ps); %Nx and Ny must be integers 
Ny = round(((Ymax+imsize_half+border) )/ps);

I = double(zeros (Nx+2*border,Ny+2*border)); %creates a matrix Ny x Nx filled with zeros - Note that x is associated to the columns and y to the rows
        Imax=0;     
        sigma=s(1);
        [Ispot, Nxspot] = gaussian_spot_vPALM(sigma,imsize,ps);
        size_spot=size(Ispot);
         
        for i=1 : N
           if ~isnan(X(i))
                xc=round(X(i)/ps)+border;
                yc=round(Y(i)/ps)+border;

                xrange=linspace(xc-imsize_half,xc+imsize_half,size_spot(1));
                yrange=linspace(yc-imsize_half,yc+imsize_half,size_spot(2));

                I(xrange,yrange)=Ispot+I(xrange,yrange);
            end
        end


PALM_image = I;%rot90(I);
ycoor=ps*[1:size(I,2)];
xcoor=ps*[1:size(I,1)];
