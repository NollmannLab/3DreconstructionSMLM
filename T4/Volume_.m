function[X,Y,Z]=Volume_(X,Z,planes)

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


%% creation of the volume
theta_ = [0:((2*pi)/(planes-1)):2*pi];

X=[];Y=[];Z=[];
coord =vertcat(X_,Y_,Z_);

for iCell = 1:size(theta_,2)%parameters.Nemitters
    Rz = [cos(theta_(iCell)) -sin(theta_(iCell)) 0; sin(theta_(iCell)) cos(theta_(iCell)) 0; 0 0 1];
    coord_ = coord'*Rz;
    Y = [Y,coord_(:,2)'];
    X = [X,coord_(:,1)'];
    Z = [Z,coord_(:,3)'];
end
