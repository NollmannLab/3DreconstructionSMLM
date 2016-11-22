%% build the geometry with all points

function[X_t,Y_t,Z_t,x1,x2,y1,y2,z1,z2]=geometry_allPoints(Ima1,Ima2,parameters)

%% main body construction
 Ima=Ima1;

 parameters.Z_Xnm=190;% Bacteriophage body length in nm
 [X,Z,ind]=Coordinates_(Ima,parameters);
 MinDistEmit=parameters.MinDistEmit;
 [Xx,Yy,Zz]=Volume_all(X,Z,parameters);
 x1=Xx;y1=Yy;z1=Zz; X_=Xx;Y_=Yy;Z_=Zz;
 length_1=size(x1,2);

%% Antoine : Resize coordinates to the right dimensions
AspectRatio =  parameters.Z_Xnm  /  (  max(z1(:)) - min(z1(:))  ) ;
x1 = x1 * AspectRatio;
y1 = y1 * AspectRatio;
z1 = z1 * AspectRatio;

 
 %figure,plot3(Xx,Yy,Zz,'ob'),grid on
 %% legs construction
 
    Ima=Ima2; 

    
    parameters.Z_Xnm=70;%parameter that define maximaZ distatnace[nm]

    X=[];Y=[];Z=[];Xx=[];Yy=[];Zz=[];X_=[];Y_=[];Z_=[];index=[];
    [X,Z,ind]=Coordinates_(Ima,parameters);% Gets localizations with the chosen density
    planes = parameters.planes+1; % planes --> Leg number
    [Xx,Yy,Zz]=Volume_(X,Z,planes);
 
    
    x2=Xx;y2=Yy;z2=Zz;
    length_2=size(x2,2);
    
    %% Resize coordinates to the right dimensions
    AspectRatio =  parameters.Z_Xnm  /  (  max(z2(:)) - min(z2(:))  ) ;
    x2 = x2 * AspectRatio;
    y2 = y2 * AspectRatio;
    z2 = z2 * AspectRatio;
    
    
 
    %% all localization construction
     X_t = horzcat(x1,x2);Y_t = horzcat(y1,y2);Z_t= horzcat(z1,z2);
 

      
