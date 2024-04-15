%% PLOT EWS MEASURES

% Var
figure_counter = figure_counter + 1;
figure(figure_counter);
tiledlayout('flow');
nexttile;
hold on
plot(time_window_ends_maxrate, var_timeseries_maxrate, 'DisplayName', 'Var', 'Color', PS.Blue1);
plot(time_window_ends_varmaxima, var_timeseries_maxima, 'Color', PS.Blue5);
xline(time_var_maxima, '--r', 'Var maxima', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Var maxima');
legend('Location', 'northwest');

% Sk
nexttile;
hold on
plot(time_window_ends_maxrate, sk_timeseries_maxrate, 'DisplayName', 'Sk', 'Color', PS.Blue1);
plot(time_window_ends_skmaxima, sk_timeseries_maxima, 'Color', PS.Blue5);
xline(time_sk_maxima, '--r', 'Sk maxima', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Sk maxima');
legend('Location', 'northwest');

% Kr
nexttile;
hold on
plot(time_window_ends_maxrate, kr_timeseries_maxrate, 'DisplayName', 'Kr', 'Color', PS.Blue1);
plot(time_window_ends_krmaxima, kr_timeseries_maxima, 'Color', PS.Blue5);
xline(time_kr_maxima, '--r', 'Kr maxima', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'Kr maxima');
legend('Location', 'northwest');

% AC
nexttile;
hold on
plot(time_window_ends_maxrate, AC_timeseries_maxrate, 'DisplayName', 'AC 1s', 'Color', PS.Blue1);
plot(time_window_ends_ACmaxima, AC_timeseries_maxima, 'Color', PS.Blue5);
xline(time_AC_maxima, '--r', 'AC maxima', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'AC maxima');
legend('Location', 'northwest');

% % Hurst
% nexttile;
% hold on
% plot(time_window_ends_maxrate, H_timeseries_maxrate, 'DisplayName', 'H', 'Color', PS.Blue1);
% plot(time_window_ends_Hmaxima, H_timeseries_maxima, 'Color', PS.Blue5);
% xline(time_H_maxima, '--r', 'H maxima', 'LineWidth', 2.5, 'FontSize', 12, 'DisplayName', 'H maxima');
% legend('Location', 'northwest');





