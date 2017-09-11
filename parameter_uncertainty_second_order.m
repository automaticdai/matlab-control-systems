% -------------------------------------------------------------------------
% parameter_uncertainty.m
% Description: 
% Exploring the influences of parameter uncertainties in a control system
% model. 
% Author:
% Xiaotian Dai, 2017
% -------------------------------------------------------------------------

close all;

%% Define the Actual System Transfer Function
% G(s) = 3 / (s^2 + s + 4)
Gs = tf([3],[1 1 4]);


%% Simulate the ideal system
SAMPLING_TIME = 0.1;
t = 0:SAMPLING_TIME:10;
t = t';
u = ones(numel(t),1);

f = figure();

% open loop response
subplot(2, 1, 1);
[y1, t1, x1] = lsim(Gs, u, t);
plot(t1, y1, 'r*');
hold on;

% closed loop response
subplot(2, 1, 2);
Gsc = feedback(Gs, 1);
[y1, t1, x1] = lsim(Gsc, u, t);
plot(t1, y1, 'r*');
hold on;


%% Simulate some variate systems
% a range, or even a distribution
% a = 2.8 - 3.2
% b = 3.8 - 4.2

para1 = linspace(2.8, 3.2, 5);
para2 = linspace(3.8, 4.2, 5);

[X,Y] = meshgrid(para1, para2);

% H(s) = a / (s^2 + s + b)
for i = 1:size(X,1)
    for j = 1:size(X,2)
        a = X(i, j);
        b = Y(i, j);
        display(sprintf('a = %f, b = %f', a, b))
        Hs = tf(a, [1 1 b]);
        
        % open loop response
        subplot(2, 1, 1);
        [y2, t2, x2] = lsim(Hs, u, t);
        plot(t2, y2, 'b');
        hold on;
        
        % closed loop response
        subplot(2, 1, 2);
        Hsc = feedback(Hs, 1);
        [y2, t2, x2] = lsim(Hsc, u, t);
        plot(t2, y2, 'b');
        hold on;
    end
end
