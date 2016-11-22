function[X,Y,Z]=Volume_all(X,Z,parameters)

%% projection of Y axis (cylindrical coordinates)
theta=0;
Y_ = []; X_ = []; Z_ = [];
%X=Xsel;Z=Zsel;
for j = 1:size(theta,2)
    y=[];
    for i = 1:size(X,2)
        yy = sqrt((X(i))^2/(1-(sin(theta(j))^2)))*sin(theta(j));
        y = [y,yy];   
    end

    Y_ = [Y_,y];
    X_ = [X_,X(:)']; X_ =X_-min(X_(:));
    Z_ = [Z_,Z(:)'];

end

coord =vertcat(X_,Y_,Z_);
%% first creation of the volume for the maximun number of points

planes_max =parameters.planes_rotation;%360
Rmax= max(X_(:));% round(59.9706)/2;
%Planes = planes_max/(parameters.MinDistEmit);
Planes = 5/Rmax; % Antoine. I set it to 5 as the density is now chosen afterwards
%Planes = parameters.MinDistEmit/Rmax;

y_max = [];x_max = [];z_max = [];y_ = [];x_ = [];z_ = [];
for i=1:size(X_,2)
   % i
    if X_(i)==max(X_(:))
    
   % theta_ = [0:((2*pi)/(Planes-1)):2*pi];theta_Total=theta_ ;
    theta_=[0:Planes:2*pi];
    X_max=[];Y_max=[];Z_max=[];Cell=[];jj=0;
    Coord=[X_(1,i),Y_(1,i),Z_(1,i)];
    for iCell = 1:size(theta_,2)%parameters.Nemitters
         Rz = [cos(theta_(iCell)) -sin(theta_(iCell)) 0; sin(theta_(iCell)) cos(theta_(iCell)) 0; 0 0 1];
        coord_ = Coord*Rz;
        Y_max = [Y_max,coord_(1,2)];
        X_max = [X_max,coord_(1,1)];
        Z_max = [Z_max,coord_(1,3)];
    end
     y_max = [y_max,Y_max];
     x_max = [x_max,X_max];
     z_max = [z_max,Z_max];
%     
    coord_Max =vertcat(x_max,y_max,z_max);
    
    else
%      planes = parameters.MinDistEmit/X_(i); 
 planes = 5/X_(i);    %Antoine
    %planes=(X_(i)*Planes)/Rmax;
    %theta_ = [0:(round(2*pi)/abs(planes-1)):2*pi] ;
    theta_ = [0:planes:2*pi] ;
    X_x=[];Y_y=[];Z_z=[];Cell=[];jj=0;
   
    Coord=[X_(1,i),Y_(1,i),Z_(1,i)];
    for iCell = 1:size(theta_,2)%parameters.Nemitters
        
        Rz = [cos(theta_(iCell)) -sin(theta_(iCell)) 0; sin(theta_(iCell)) cos(theta_(iCell)) 0; 0 0 1];
        coord_ = Coord*Rz;
        Y_y = [Y_y,coord_(1,2)];
        X_x = [X_x,coord_(1,1)];
        Z_z = [Z_z,coord_(1,3)];
    end
     y_ = [y_,Y_y];
     x_ = [x_,X_x];
     z_ = [z_,Z_z];
%     
    coord_c =vertcat(x_,y_,z_);
  
    end
end

 X = horzcat(x_,x_max);
 Y = horzcat(y_,y_max);
 Z = horzcat(z_,z_max);
