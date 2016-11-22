%% build the geometry 

function[cluster]=geometry_SelPoints_v2(X_t,Y_t,Z_t,x1,x2,y1,y2,z1,z2,parameters)
%function[f2,cluster]=geometry_v6(Ima1,Ima2,parameters)

 parameters.L_Xnm = 65;%teorethical size in nm
 MinDistEmit = parameters.MinDistEmit;
   
 %% determine the total N of emitters 
 
 if parameters.Nemitters>size(X_t,2)
     N=size(X_t,2);
     percent=1;
 else
     N=parameters.Nemitters;
     percent=(N*1)/size(X_t,2);
 end
 
 %% selecting the emitters
    numelements = round(percent*length(X_t));
    clear X_ Y_ Z_
    DistanceMatrix = squareform(pdist([X_t',Y_t',Z_t']));
    Coord = [X_t',Y_t',Z_t'];
    i = 1;
    while i<=numelements & size(DistanceMatrix)>0 %i<=1000 & size(DistanceMatrix)>0
       [y, Idx] = datasample(DistanceMatrix,1); % randomly pick one emitter

        X_(i) = Coord(Idx,1); % Get its coordinates
        Y_(i) = Coord(Idx,2);
        Z_(i) = Coord(Idx,3);

        IndDel = find( DistanceMatrix(Idx,:) < MinDistEmit); % Find neighboors closer than the desired density
        DistanceMatrix(IndDel,:) = []; % take them off the distance matrix
        DistanceMatrix(:,IndDel) = [];
        Coord(IndDel,:) = [];
        i=i+1;
    end
%     fprintf('\n Nb selected emitters = %4.f \n',i)
%     figure
%     scatter3(X_,Y_,Z_,'r.')
%     daspect([1,1,1])
%     set(gcf,'Color',[1 1 1]);
   fprintf('\n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
   fprintf('\n Nb of potential emitters = %4.f \n',numel(X_t))
   fprintf('\n Nb selected emitters from structure= %4.f \n',numel(intersect(X_,X_t)))
   fprintf('\n Nb selected emitters from head+trunc= %4.f \n',numel(intersect(X_,x1)))
   fprintf('\n Nb selected emitters from legs= %4.f \n',numel(intersect(X_,x2)))
   fprintf('\n Percentage in legs= %4.f \n',numel(intersect(X_,x2))/numel(intersect(X_,X_t)) *100 )
   fprintf('\n %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n')
      %% choosing the number of emitters
    
      if parameters.Multi_locperEmitter==0
        emitters=parameters.Nemitters;    
        if emitters>size(X_,2)
            emitters=size(X_,2);
        end        
        for i=1:emitters
            cluster_x(i) =X_(1,i)+incert;%/parameters.px_size)*parameters.ps;%/size(Ima,1))*parameters.xsize;
            cluster_y(i) =Y_(1,i)+incert;%/parameters.px_size)*parameters.ps;%/size(Ima,2))*parameters.ysize;
            cluster_z(i) =Z_(1,i)+incert;%/parameters.px_size)*parameters.ps;%/size(Ima,2))*parameters.ysize;
            cluster{1,i} = cluster_x(i); cluster{2,i} = cluster_y(i);cluster{3,i} = cluster_z(i);
        end

      else
        emitters=parameters.Nemitters;
        if emitters>size(X_,2)
            emitters=size(X_,2);
        end
        for i=1:emitters
            [incert]=incerteza2(parameters); % define the locaization precision to be added (nm)
            cluster_x = X_(1,i) + incert(1,:);%/parameters.px_size)*parameters.ps;%/size(Ima,1))*parameters.xsize;
            cluster_y = Y_(1,i) + incert(2,:);%/parameters.px_size)*parameters.ps;%/size(Ima,2))*parameters.ysize;
            cluster_z = Z_(1,i) + incert(3,:);%/parameters.px_size)*parameters.ps;%/size(Ima,2))*parameters.ysize;

            cluster{1,i} = cluster_x;%/(parameters.ps*10); 
            cluster{2,i} = cluster_y;%/(parameters.ps*10);
            cluster{3,i} = cluster_z;%/(parameters.ps*10);
        end
      end %endif
      
end % function  
      