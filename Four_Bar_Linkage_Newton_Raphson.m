%% 4-Bar Linkage: Newton-Raphson Method 
% Script designed to find theta_3 and theta_4 of a 4-bar linkage

% Clean up the MATLAB workspace:
clear all; clc; close all;

%% Initialize: 
theta_2 = 60;
r_1 = 0.18;
r_2 = 0.06;
r_3 = 0.15;
r_4 = 0.08;
% Initial guess of angles:
theta_3 = 180; 
theta_4 = 90;  
% Define matrix:
C = [10;10];
F = [0;0];
num_iterations = 0;
end_loop = 0;

%% Newton-Raphson's Method:
while (end_loop == 0)
    % Matrix J is the Jacobian:
    J = [r_3*sind(theta_3) r_4*sind(theta_4); -r_3*cosd(theta_3) -r_4*cosd(theta_4)];
    J_inverse = -inv(J);
    F = [f1(theta_3, theta_4, r_1, r_2, r_3, r_4); f2(theta_3, theta_4, r_2, r_3, r_4)];
    B = [theta_3; theta_4];
    A = (J_inverse*F) + B;
    theta_3 = A(1);
    theta_4 = A(2);
    C = A - B;
    %theta_3 = mod(C(1) + B(1), 360);
    %theta_4 = mod(C(2) + B(2), 360);
    num_iterations = num_iterations + 1;
    if (abs(C(1)) < 0.001 && abs(C(2)) < 0.001)
        end_loop = 1;
    end
end 

%% Print Results:
fprintf('\n theta_3=%.3f',theta_3);
fprintf('\n theta_4=%.3f',theta_4);

%% Helper Functions:
function output_1 = f1(theta_3, theta_4, r_1, r_2, r_3, r_4)
    output_1 = 0.5*r_2 - r_3*cosd(theta_3) - r_4*cosd(theta_4) - r_1;
end

function output_2 = f2(theta_3, theta_4, r_2, r_3, r_4)
    output_2 = (sqrt(3)/2)*r_2 - r_3*sind(theta_3) - r_4*sind(theta_4);
end

