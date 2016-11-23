 
function[incert]=incerteza2(parameters)
factor=1/2.35; %FWHM = 2.35 x std

    if parameters.Multi_locperEmitter==0
        incert = 0;
    else

        NLocperEmitter = randn(1)*parameters.loc_perEmitter/2+parameters.loc_perEmitter;
        while NLocperEmitter<0
            NLocperEmitter = randn(1)*parameters.loc_perEmitter/2+parameters.loc_perEmitter;
        end
       NLocperEmitter = round(NLocperEmitter);
       loc_precision = parameters.pointing_precision_px * parameters.px_size;
       incert_x = normrnd(0,loc_precision*factor,[1,NLocperEmitter]);
       incert_x = [incert_x 0];
       incert_y = normrnd(0,loc_precision*factor,[1,NLocperEmitter]);
       incert_y = [incert_y 0];
       incert_z = normrnd(0,loc_precision*factor,[1,NLocperEmitter]);
       incert_z = [incert_z 0];
       
       incert = [incert_x;incert_y;incert_z] ;

    end
end