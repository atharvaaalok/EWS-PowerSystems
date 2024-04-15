clear; clc; close all;
PS = PLOT_STANDARDS();

figure_counter = 0;

%==================================================
% INITIAL CONDITIONS

Pm_bifn = 0.6495;

delta0 = 1;
x0 = cos(delta0);
y0 = sin(delta0);
omega0 = 1.26;
E0 = 1;
Pm0 = .58;

% Time Range details
% nsteps = 1000000;
sampling_rate = 5001;
delta_t = 1 / (sampling_rate - 1);     % the actual formula should be 1 / (sampling_rate - 1), but I use this as an approximation as integer multiple (5000) makes 1 second.
t1 = 0;

Y0 = [x0; y0; omega0; E0; Pm0];

% mu_list = 0.001:0.0005:0.008;
% t2_list = 300 * ones(1, length(mu_list));
a = 0.0001: 0.00005: 0.0030;
mu_list = a;

limitcycle_factor = 140 / 100;
Pm_bifn_slope = (0.69 - Pm_bifn) / 0.0023;
Pm_bifn_list = Pm_bifn + Pm_bifn_slope * (mu_list);
t2_list = floor( ((Pm_bifn_list - Pm0) ./ mu_list) * limitcycle_factor );

figure_counter = figure_counter + 1;

for i = 1: length(mu_list)
    mu = mu_list(i);
    t2 = t2_list(i);
    
    filename = sprintf('Data/Noise5/NoiseOmega5_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.5f_t%.2f_deltaT%.5f_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, delta_t);
    load(filename);
    
    tSol;
    YSol = YSol';
    xSol = YSol(1, :);
    ySol = YSol(2, :);
    omegaSol = YSol(3, :);
    ESol = YSol(4, :);
    PmSol = YSol(5, :);
    
    
    %% PLOT THE DATA
    
%     figure_counter = figure_counter + 1;
    figure(figure_counter);
    hold on
    plot(tSol, omegaSol);
    
    title(sprintf('$$\\mu = %.5f$$', mu), 'Interpreter', 'Latex');
    xlabel('Time');
    ylabel('$$\\omega$$', 'Interpreter', 'Latex');
    
    pause(0.25);
    
    clf(gcf);

end

