%SimDuckling_Main.m
%% parameters
%clc;%close all;%clear all

ima_factor = 0;

dlg_title = 'Parameters';
num_lines = 1;
def = {'103','5','15','4000','0.6','1','0','30','5','0','2e3','0'};
%def = {'103','2.5','2','10','10','1','1','30','0','0','2e3','.1','0'};
prompt = {'Pixel size(nm):','SR-Pixel size(nm):',...
    'localization precision (nm) :','N_Clust :','N_Points :',...
    'Multi events per Emitter, no=0,yes=1','delta n�loc, no=0,yes=1',...
    'Max. n�Loc per Emitter :','Min dist between emitters(nm)',...
     '% noise :','Max. A (u.a):','% noise Int :'};

answer = inputdlg(prompt,dlg_title,num_lines,def);

parameters.px_size = str2double(answer{1}); % Pixel size of aquired localization data (103nm)
parameters.ps = str2double(answer{2});% Pixel size of reconstructed data (5nm)
parameters.pointing_precision_px = str2double(answer{3})/parameters.px_size; % localization precision
parameters.N_Clust = str2double(answer{4}); % Number of origami to simulate
parameters.Nemitters = str2double(answer{5}); % Total number of emitters to simulate

parameters.Multi_locperEmitter= str2double(answer{6});
parameters.deltaNLoc= str2double(answer{7});
parameters.loc_perEmitter= str2double(answer{8});

parameters.loc_precision=parameters.pointing_precision_px ;
parameters.MinDistEmit=str2double(answer{9});%nm
parameters.perc_noise = str2double(answer{10});
parameters.maxA = str2double(answer{11});
parameters.percen_IntNoise = str2double(answer{12});

pixel_size = parameters.px_size;px_size=parameters.px_size;
ps = parameters.ps; %SR px
N_Clust = parameters.N_Clust;%5000;% numero de cluster -- total number of images
N_Points = parameters.Nemitters;% numero de localizaciones por cluster
maxA = parameters.maxA;

pointing_precision_px = parameters.pointing_precision_px;%.2;%2;%.03% nm

Multi = parameters.Multi_locperEmitter;
loc_perEmitter = parameters.loc_perEmitter;
loc_precision_px = parameters.pointing_precision_px;%.2;%2;%.03% nm

perc_noise_total = (parameters.perc_noise/100)*parameters.loc_perEmitter*N_Points;
percen_IntNoise = parameters.percen_IntNoise*maxA;% intensity of the noise of number of localization non specific
%% Display Input parameters
disp(['Pixel size of aquired localization data = ' num2str(parameters.px_size)]) ;
disp(['Pixel size of reconstructed data = ' num2str(parameters.ps)]) ;
disp(['Localization precision (FWHM) = ' num2str(answer{3})]) ;
disp(['Number of origami to simulate = ' num2str(parameters.N_Clust)]) ;
disp(['Total number of emitters to simulate = ' num2str(parameters.Nemitters)]) ;
disp(['Multi_locperEmitter??? = ' num2str(parameters.Multi_locperEmitter)]) ;
disp(['deltaNLoc??? = ' num2str(parameters.deltaNLoc)]) ;
disp(['Total number of emitters to simulate = ' num2str(parameters.Nemitters)]) ;

disp(['Labeling density = ' num2str(parameters.MinDistEmit)]) ;
disp(['perc_noise??? = ' num2str(parameters.perc_noise)]) ;
disp(['maxA??? = ' num2str(parameters.maxA)]) ;
disp(['percen_IntNoise??? = ' num2str(parameters.percen_IntNoise)]) ;


%save the variable 
Folder = uigetdir(path,'Choose path to write output data');
f1=fullfile(Folder,strcat('Sim-NClust',num2str(N_Clust),'_NPoints',num2str(N_Points),'_LPrec',num2str((pointing_precision_px*pixel_size)),'_SRpx',num2str(ps),...
    '_PercBack',num2str(perc_noise_total*100),'_MinDistEmit',num2str(parameters.MinDistEmit)));
if (exist(f1) == 0)
   mkdir (f1);
end
cd(f1)

%% define geometry and generate labeling sites
Simulation_Duckling;

if parameters.Nemitters == 0
   parameters.Nemitters = numel(X_t);
   N_Points = parameters.Nemitters;
elseif parameters.Nemitters > 0 & parameters.Nemitters <1
   parameters.Nemitters = round( parameters.Nemitters * numel(X_t)); 
   N_Points = parameters.Nemitters;
end
disp(['Number of labeling sites used = ' num2str(N_Points)]) ;
%% Select points datasets from possibilities defined previsously
disp(['Number of simulations to perform = ' num2str(N_Clust)]) ;
fprintf('\nCounter: ')
for k=1:N_Clust 
    % Display counter
    if k>1
          for j=0:log10(k-1)
              fprintf('\b'); % delete previous counter display
          end
    end
      fprintf('%d', k);
    
    
    ind=rand(N_Clust,1)';
    
    [cluster]=geometry_SelPoints_Spirale(X_t,Y_t,Z_t,parameters);
    
    
    Positions=[];
    cluster = cell2mat(cluster);

    X=cluster(1,:);
    Y=cluster(2,:);  
    Z=cluster(3,:);
 
         
     for jj=1:size(X,2)
        Positions(jj,1)=X(jj)';
        Positions(jj,2)=Y(jj)';
        Positions(jj,3)=Z(jj)';
     end
    
    %% cambiar orientacion
     [Positions]=rndRot_v2(Positions);
%     figure
%     scatter3(Positions(:,1),Positions(:,2),Positions(:,3),'b.'),daspect([1,1,1])
    %% writting the matrix
    Struct{1,k}=[Positions];
    Struct{2,k}=[Positions];
    Struct{2,k}(:,4)=[rand(1,size(X,2))*pixel_size*3];
    Struct{2,k}(:,5)=[rand(1,size(X,2))*maxA];

    % save simulated data in a matrix

    mx=zeros(N_Points,N_Clust);
    my=zeros(N_Points,N_Clust);
    mz=zeros(N_Points,N_Clust);
    
    
    mx=(Struct{2,k}(:,1)');%/parameters.px_size)*parameters.ps;%mx=(mx(:)');%in px 
    my=(Struct{2,k}(:,2)');%/parameters.px_size)*parameters.ps;%my=(my(:)');%in px
    mz=(Struct{2,k}(:,3)');%/parameters.px_size)*parameters.ps;%my=(my(:)');%in px
    
      frame_n=[1:size(my,2)]; 
      S = [rand(1,size(my,2))*pixel_size*3];%in nm
      A = [rand(1,size(my,2))*maxA];
      m = vertcat(frame_n,mx-mean(mx),my-mean(my),S,A,mz-mean(Struct{2,k}(:,3)'));
       
 %% adding noise 
     if percen_IntNoise>0
         Noise=zeros(size(mx,2),size(my,2));
         rp=randperm(size(mx,2)*size(my,2));
          percet_noise = perc_noise_total; 
         Noise(rp(1:percet_noise))=1;
         [row,col] = find(Noise==1);
         Positions_noise_x = col';
         Positions_noise_y = row';

         frame_noise=[1:size(Positions_noise_y,2)]; 
         S_noise = [rand(1,size(Positions_noise_y,2))*px_size*3];%in nm
         A_noise = [randi(percen_IntNoise,1,size(Positions_noise_y,2))];
         m_noise = vertcat(frame_noise,Positions_noise_x,Positions_noise_y,S_noise,A_noise);

         Struct{3,k} =  m;
         m= horzcat(m,m_noise);
         Struct{4,k} =  The(k);   
     end  

    %% PD images

    snm=ones(size(m(2,:),2),1)'*loc_precision_px*px_size/2.35; %FWHM = 2.35 x std
    border= round(px_size*.7);%border= round(10);
    Pixel_to_photon=1;uniform_peaks=1;max_intensity=1;
    hot=1;logyes=0;
      % units on "nm"

      [I,xcoor,ycoor,Imax]=vPALM_reconstruction_v6(m(2,:),m(3,:),snm,m(5,:),ps,border,Pixel_to_photon,uniform_peaks, max_intensity, hot,logyes);

 
    %resize Image to make it 100x100 pixels
    [rows cols] = size(I);
    if rows>100
        I2 = I(round(rows/2-49):round(rows/2+50),:);
    elseif rows<100
        I2 = I;
        I2(end:100,:)=0;
    else
        I2=I;
    end
    if cols>100
        I2 = I2(:,round(cols/2-49):round(cols/2+50));
    elseif rows<100
         I2(:,end:100)=0;
    end

%% Create an ROI of 100x100 around the COM of the object.
BW = I>0.1;
[rows,cols] = size(BW);
x = ones(rows,1)*[1:cols];    % Matrix with each pixel set to its x coordinate
y = [1:rows]'*ones(1,cols);   %   "     "     "    "    "  "   "  y    "

area = sum(sum(BW));
meanx = sum(sum(double(BW).*x))/area;
meany = sum(sum(double(BW).*y))/area;
I2 = I(round(meany-49):round(meany+50),:);
I2 = I2(:,round(meanx-49):round(meanx+50));   

    % Display and save image
    figure,imagesc(xcoor,ycoor,uint16(I2));axis tight; colormap(gray);
    set(findobj(gcf, 'type','axes'), 'Visible','off');
    set(gca,'position',[0 0 1 1],'units','normalized')
    set(gcf, 'Units','centimeters', 'Position',[0 0 5 5]);
    set(gcf, 'PaperPositionMode','auto')
    filename=strcat('Normal_',num2str(k+ima_factor));
    fileRes=strcat('-r',num2str(size(I2,1)),'.mrc');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 1 1])
    print('-dtiff',fileRes,filename) 
    imwrite(uint16(I2),'stack.tiff', 'writemode', 'append');
    close

    %WriteMRC(I2,50,filename);

%% Plot localizations
%     figure(654)
%     scatter3(Positions(:,1),Positions(:,2),Positions(:,3),'.')
%     daspect([1 1 1])
% 
    Positions=[];Positions_=[];

end




      %% saving datas
 
  fileMAT = strcat('Sim_maxAmp',num2str(parameters.maxA),'_MultEmit',num2str(Multi),...
    '_MaxLocperEmitter',num2str(loc_perEmitter),'_deltaNLoc',num2str(parameters.deltaNLoc));
  [SaveName,SavePath]=uiputfile(fileMAT);
  cd(SavePath);
  save(SaveName,'Struct','m','parameters');

