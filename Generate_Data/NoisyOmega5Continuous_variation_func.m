function dYdt = NoisyOmega5Continuous_variation_func(t, Y, mu)
    % get variables
    x = Y(1);
    y = Y(2);
    omega = Y(3);
    E = Y(4);
    Pm_val = Y(5);
    
    % Hit Pm_val with 5-10% Gaussian Noise
    mean = 0; sigma = 1;
    noise_percent = 5/100;
    noise = noise_percent * normrnd(mean, sigma);
    
    % calculate derivatives corresponding to each variable
    dxdt = -y*omega + x*(1-x*x-y*y);
    dydt = x*omega + y*(1-x*x-y*y);
    domegadt = -3.33*E*y - 0.66*omega + 3.33 * Pm_val + 3.33 * noise;
    dEdt = 0.5*x - E + 0.5;
    dPmdt = mu;
    
    % set vector of derivatives
    dYdt = [dxdt; dydt; domegadt; dEdt; dPmdt];

end