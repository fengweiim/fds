% McDermott
% 13 Feb 2021
% pan_with_lip.m
% conversion of pan_with_lip.f90 (mcgratta) to matlab
%
% Estimate area of intersection of circle with origin (X0,Y0), radius, RAD, and rectangle (X1,Y1,X2,Y2)
% All dimensions in meters

X0 = 0.;
Y0 = 0.;
Z1 = -0.04;
Z2 = 0.;
RAD = 0.1524;
PAN_THICKNESS = 0.015;
LIP_HEIGHT = 0.01;
IBAR = 30;
JBAR = 30;
XS = -0.3;
XF = 0.3;
YS = -0.3;
YF = 0.3;

RAD2 = RAD + PAN_THICKNESS;
DX = (XF-XS)/double(IBAR);
DY = (YF-YS)/double(JBAR);
AREA = 0.;

fid = fopen('pan.txt','w');

for J=1:JBAR
    Y = YS + DY*(J-0.5);
    for I=1:IBAR
        X = XS + DX*(I-0.5);
        if ((X-X0)^2+(Y-Y0)^2)<RAD^2
            fprintf(fid,'%s %6.3f, %6.3f, %6.3f, %6.3f, %6.3f, %6.3f, %s \n', ...
                "&OBST XB=",X-0.5*DX,X+0.5*DX,Y-0.5*DY,Y+0.5*DY,Z1,Z2, " SURF_IDS='POOL','PAN','PAN' /");
            AREA = AREA + DX*DY;
        elseif ((X-X0)^2+(Y-Y0)^2)<RAD2^2
            fprintf(fid,'%s %6.3f, %6.3f, %6.3f, %6.3f, %6.3f, %6.3f, %s \n', ...
                "&OBST XB=",X-0.5*DX,X+0.5*DX,Y-0.5*DY,Y+0.5*DY,Z1,Z2+LIP_HEIGHT, " SURF_ID='PAN' /");
        end
    end
end

disp(['Area of pan is ',num2str(AREA),' m2'])

fclose(fid);
