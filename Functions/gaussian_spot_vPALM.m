%% Create image of gaussian spot of standard deviation sigma
%
% M nollmann
function [Ispot, Nxspot] = gaussian_spot_vPALM(sigma_nm,imsize,ps)
sigma=sigma_nm/ps;
x=[1:imsize];
[X,Y]=meshgrid(x,x);
D=(X-imsize./2-.5).^2+(Y-imsize./2-.5).^2;
Ispot=exp(-(D)/(2*sigma^2));
Ispot = double(Ispot);%/sum(Ispot(:)); %normalize to unit energy by area   
Nxspot=x;
% q = 3; % half-size of the spot image in terms of number of standard deviations
% Nxspot = ceil(q*sigma/dx)*2+1;
% aux1 = (linspace(-q*sigma, q*sigma,Nxspot)).^2;     % x^2
% aux2 = repmat(aux1(:),1,Nxspot);
% aux3 = repmat(aux1,Nxspot,1);
% Ispot = exp(-(aux2+aux3)/(2*sigma^2));  % exp( - (x^2+y^2)/(2*sigma^2) )
% if 1==1 % normalize to unit energy by area   
%     Ispot = Ispot/sum(Ispot(:));
% end

end