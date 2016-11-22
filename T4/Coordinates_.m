function[X,Z,ind]=Coordinates_(Ima,parameters)
% Gets localizations with the chosen density


for i=1:size(Ima,2)
    for j=1:size(Ima,1)
       if Ima(i,j)>0
         Ima(i,j) = 1;
       end
    end
end

[fil,col] = find(Ima==1);
ind = [fil,col];
cluster = {};

%% All_coordinates from image

for i=1:size(ind,1)%parameters.Nemitters
     cluster{1,i}.x=(ind(i,2)');%/parameters.px_size)*parameters.ps;%/size(Ima,1))*parameters.xsize;
     cluster{1,i}.z=(ind(i,1)');%/parameters.px_size)*parameters.ps;%/size(Ima,2))*parameters.ysize;
    % cluster{1,i}.phi = atan((ind(i,1)')/(ind(i,2)')); 
end 

 for iCell=1:size(ind,1)%parameters.Nemitters
     X(iCell) = [[],cluster{1,iCell}.x];
     Z(iCell) = [[],cluster{1,iCell}.z]; 
     %phi(iCell) = [[],cluster{1,iCell}.phi]; 
 end
 
 %% controling density
   MinDistEmit=parameters.MinDistEmit;%nm
   Z_Xnm = parameters.Z_Xnm;
   
 
   %[X,Z]=DensControl(X,Z,MinDistEmit,Z_Xnm);
  
 