%% random rotation

function[Positions]=rndRot_v2(Positions)
the = rand(1)*2*pi;
 Rx = [1 0 0; 0 cos(the) -sin(the); 0 sin(the) cos(the)];
 the = rand(1)*2*pi;
 Ry = [cos(the) 0 sin(the)  ; 0 1 0; -sin(the) 0 cos(the)];
 the = rand(1)*2*pi;
 Rz = [cos(the) -sin(the) 0; sin(the) cos(the) 0; 0 0 1];


        Positions=Positions*Rx;

        Positions=Positions*Ry;

        Positions=Positions*Rz;
       
end
