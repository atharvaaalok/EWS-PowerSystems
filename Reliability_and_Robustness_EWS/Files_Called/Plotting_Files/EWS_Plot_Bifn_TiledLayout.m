%% PLOT EWS MEASURES

% Original timeseries
figure_counter = figure_counter + 1;
figure(figure_counter);
tiledlayout('flow');
nexttile;
plot(time_bifn_ts, state_timeseries_bifn, 'DisplayName', 'TimeSeries');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');

% RMS
% figure_counter = figure_counter + 1;
% figure(figure_counter);
% tiledlayout('flow');
nexttile;
plot(time_window_ends_bifn, rms_timeseries_bifn, 'DisplayName', 'RMS');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');
% 
% % Rate RMS
% % figure_counter = figure_counter + 1;
% % figure(figure_counter);
% % tiledlayout('flow');
% nexttile;
% plot(time_vector{n}, rms_omega{n}, 'DisplayName', 'Rate RMS');
% xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
% legend('Location', 'northwest');

% Var
% figure_counter = figure_counter + 1;
% figure(figure_counter);
% tiledlayout('flow');
nexttile;
plot(time_window_ends_bifn, var_timeseries_bifn, 'DisplayName', 'Var');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');

% Sk
% figure_counter = figure_counter + 1;
% figure(figure_counter);
% tiledlayout('flow');
nexttile;
plot(time_window_ends_bifn, sk_timeseries_bifn, 'DisplayName', 'Sk');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');

% Kr
% figure_counter = figure_counter + 1;
% figure(figure_counter);
% tiledlayout('flow');
nexttile;
plot(time_window_ends_bifn, kr_timeseries_bifn, 'DisplayName', 'Kr');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');

% AC Lag 1 second
% figure_counter = figure_counter + 1;
% figure(figure_counter);
% tiledlayout('flow');
nexttile;
plot(time_window_ends_bifn, AC_timeseries_bifn, 'DisplayName', 'AC 1s');
xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
legend('Location', 'northwest');

% % Hurst
% % figure_counter = figure_counter + 1;
% % figure(figure_counter);
% % tiledlayout('flow');
% nexttile;
% plot(time_window_ends_bifn, H_timeseries_bifn, 'DisplayName', 'H');
% xline(time_bifn, '--r', 'Bifurcation', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Bifurcation');
% legend('Location', 'northwest');





