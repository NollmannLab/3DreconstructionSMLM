function Vol = Coord2Vol(X,Y,Z,VolSize,VoxSize);
% X,Y,Z : arrays of coords in nm
% VolSize is a 3 elements array with XYZ dimensions of the output volume in
% pixels
% VoxSize is a 3 elements array with XYZ dimensions of a voxel in nm

%ex: Vol = Coord2Vol(X_t,Y_t,Z_t,[100 100 100],[5 5 5]);

Xmin = min(X);
Xmax = max(X);
Ymin = min(Y);
Ymax = max(Y);
Zmin = min(Z);
Zmax = max(Z);

% Centers the object within the output volume
X=X-Xmin-(Xmax-Xmin)/2+VolSize(1)*VoxSize(1)/2;
Y=Y-Ymin-(Ymax-Ymin)/2+VolSize(2)*VoxSize(2)/2;
Z=Z-Zmin-(Zmax-Zmin)/2+VolSize(3)*VoxSize(3)/2;


border = 1;
Vol = zeros(VolSize);

for i = 1:numel(X)
    xc=round(X(i)/VoxSize(1))+border;
    yc=round(Y(i)/VoxSize(2))+border;
    zc=round(Z(i)/VoxSize(3))+border;

    Vol(xc,yc,zc)=1000;
end


