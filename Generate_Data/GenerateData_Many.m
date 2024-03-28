clear; clc; close all;


% Generate timeseries several times

n = 100;

for k = 1: n
    fprintf('k = %d\n', k);

    % Make folder to hold timeseries
    folder_name = sprintf('Noise5_Many/%d', k);
    mkdir(folder_name);

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
    % mu_list = [0.0001];
    % t2_list = [2000];
    
    mu_list = 0.0001: 0.00005: 0.0030;
    
    % limitcycle_factor_list = linspace(1.40, , length(mu_list));
    limitcycle_factor = 140 / 100;
    Pm_bifn_slope = (0.69 - Pm_bifn) / 0.0023;
    Pm_bifn_list = Pm_bifn + Pm_bifn_slope * (mu_list);
    t2_list = floor( ((Pm_bifn_list - Pm0) ./ mu_list) * limitcycle_factor );
    
    % Generate timeseries
    fprintf('i = ');
    for i = 1:length(mu_list)
        fprintf('%d, ', i);
        t2 = t2_list(i);
        mu = mu_list(i);
        
        tRange = t1: delta_t: t2;
        
        for j = 1:5
            if j == 1
                % % Save clean data
                % YSol = ode4(@(t,y) CleanContinuous_variation_func(t, y, mu), tRange, Y0);
                % tSol = tRange;
                % filename = sprintf('Clean/Clean_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.5f_t%.2f_deltaT%.5f_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, delta_t);
                % save(filename, 'tSol', 'YSol');
            elseif j == 2
                % Save Noise 5% data
                YSol = ode4(@(t,y) NoisyOmega5Continuous_variation_func(t, y, mu), tRange, Y0);
                tSol = tRange;
                filename = sprintf('Noise5_Many/%d/NoiseOmega5_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.5f_t%.2f_deltaT%.5f_ConstantTimeStep.mat', k, delta0, omega0, E0, Pm0, mu, t2, delta_t);
                save(filename, 'tSol', 'YSol');
            elseif j == 3
                % % Save Noise 10% data
                % YSol = ode4(@(t,y) NoisyOmega10Continuous_variation_func(t, y, mu), tRange, Y0);
                % tSol = tRange;
                % % filename = sprintf('Noise10/NoiseOmega10_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.4f_t%.2f_nsteps%d_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, nsteps);
                % save(filename, 'tSol', 'YSol');
            elseif j == 4
                % % Save Noise 10% data
                % YSol = ode4(@(t,y) NoisyOmega15Continuous_variation_func(t, y, mu), tRange, Y0);
                % tSol = tRange;
                % % filename = sprintf('Noise15/NoiseOmega15_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.4f_t%.2f_nsteps%d_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, nsteps);
                % save(filename, 'tSol', 'YSol');
            elseif j == 5
                % % Save Noise 10% data
                % YSol = ode4(@(t,y) NoisyOmega20Continuous_variation_func(t, y, mu), tRange, Y0);
                % tSol = tRange;
                % % filename = sprintf('Noise20/NoiseOmega20_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.4f_t%.2f_nsteps%d_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, nsteps);
                % save(filename, 'tSol', 'YSol');
            end
            
            
        end
    
        
    end
    fprintf('\n\n');



end