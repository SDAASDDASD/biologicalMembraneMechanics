% B-spline curve estimation (control points estimation) from data about points on curve.
% Author : rudraa (Implemented using the bspline library by Levente Hunyadi)
% https://www.mathworks.com/matlabcentral/fileexchange/27374-b-splines
%
clear all; 
% spline order
k = 3; %Order in IGa notation is one less than the notation here. So k=3 is a 2nd order curve.
% knot sequence
%t = [0 0 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1 1 ];
numKnots=40;
t = [0 0 linspace(0,1,numKnots/2) 1 1 ]; %k repetitions of 0 and 1 at the ends of the knot vector
%
R=1.0;
H=10*R;
r=0.5*R;
%
theta=linspace(0,2*pi,numKnots); %theta=theta(2:end);
M=[R.*cos(theta); R.*sin(theta)];

    
D = bspline_estimate(k,t,M);
C = bspline_deboor(k,t,D);
D(:,1)=[R,0];
D(:,end)=[R,0];
% plot control points and spline
figure;
hold all;
plot(M(1,:), M(2,:), 'k');
plot(D(1,:), D(2,:), 'rx');
plot(C(1,:), C(2,:), 'c');
legend('data', 'estimated control points', 'estimated curve', ...
    'Location', 'Best');
hold off;
axis equal;
%save to file
order=k-1;
knots=t;
controlPoints=D;
save(['circle' num2str(numKnots) '.mat'],'order','knots','controlPoints','-v6') %version 6 format needed to read into python using scipy.io.loadmat
