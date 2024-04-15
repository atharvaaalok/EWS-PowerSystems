%% INITIAL SETUP

clear; clc; close all;
PS = PLOT_STANDARDS();
figure_counter = 0;


%% PREPARE BIFURCATION DATA TO PLOT

load('BifurcationData.mat');

% Prepare Fixed Point Data
FixedPointData_Bifurcation = table2array(FixedPointData_Bifurcation);
FP_omega_List = FixedPointData_Bifurcation(3, :);
FP_Pm_List = FixedPointData_Bifurcation(5, :);

selection_idx_FP = FP_Pm_List > 0;
FP_Pm_List = FP_Pm_List(selection_idx_FP);
FP_omega_List = FP_omega_List(selection_idx_FP);

% Fixed Points Bifurcation Point
[FP_Pm_Bifurcation, FP_Pm_Bifurcation_idx] = max(FP_Pm_List);
FP_omega_Bifurcation = FP_omega_List(FP_Pm_Bifurcation_idx);


% Prepare Limit Cycle Data
LCCombinedData_Bifurcation = table2array(LCCombinedData_Bifurcation);
LC_Pm_List = LCCombinedData_Bifurcation(end, :);
% LC_data = fliplr(LC_data);
[LC_table_rows, LC_table_cols] = size(LCCombinedData_Bifurcation);
LC_omega_mat = zeros(floor(LC_table_rows/4), LC_table_cols);

for i = 0:(floor(LC_table_rows/4) - 1)
    LC_omega_mat(i+1, :) = LCCombinedData_Bifurcation(3+4*i, :);
end

LC_omega_min = min(LC_omega_mat);
LC_omega_max = max(LC_omega_mat);


LC_total_Pm = length(LC_Pm_List);
% choose every ith point
LC_skip = 17;
LC_Pm_List = LC_Pm_List(1 : LC_skip: end);
LC_omega_min = LC_omega_min(1 : LC_skip: end);
LC_omega_max = LC_omega_max(1 : LC_skip: end);

% Restrict largest Pm for Limit cycle
selection_Pm_max_LC = LC_Pm_List < 1;
LC_Pm_List = LC_Pm_List(selection_Pm_max_LC);
LC_omega_min = LC_omega_min(selection_Pm_max_LC);
LC_omega_max = LC_omega_max(selection_Pm_max_LC);

LC_omega_min_max = [LC_omega_min; LC_omega_max];


% Limit Cycle Bifurcation Point
LC_Pm_Bifurcation = LC_Pm_List(end);
LC_omega_Bifurcation_min = LC_omega_min(end);
LC_omega_Bifurcation_max = LC_omega_max(end);
LC_omega_Bifurcation = linspace(LC_omega_Bifurcation_min, LC_omega_Bifurcation_max, 13);


%% IMPORT TIMESERIES DATA TO PLOT ON THE BIFURCATION DIAGRAM

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

% mu_list = 0.0001: 0.00005: 0.0030;
% mu_list = 0.0017: 0.00005: 0.0026;
% mu_list(1) = 0.0001;
mu_list = 0.0001: 0.00005: 0.0030;

limitcycle_factor = 140 / 100;
Pm_bifn_slope = (0.69 - Pm_bifn) / 0.0023;
Pm_bifn_list = Pm_bifn + Pm_bifn_slope * (mu_list);
t2_list = floor( ((Pm_bifn_list - Pm0) ./ mu_list) * limitcycle_factor );

% Load timeseries
for k = 1: length(mu_list)

    mu = mu_list(k);
    t2 = t2_list(k);

    filename = sprintf('../../Generate_Data/Data/Noise5/NoiseOmega5_delta%.2f_omega%.2f_E%.2f_Pm%.4f_mu%.5f_t%.2f_deltaT%.5f_ConstantTimeStep.mat', delta0, omega0, E0, Pm0, mu, t2, delta_t);
    Data = load(filename);

    time{k} = Data.tSol;
    YSol{k} = Data.YSol';
    xSol{k} = YSol{k}(1, :);
    ySol{k} = YSol{k}(2, :);
    omegaSol{k} = YSol{k}(3, :);
    ESol{k} = YSol{k}(4, :);
    PmSol{k} = YSol{k}(5, :);

end


%% PLOT THE TIMESERIES ON BIFURCATION DIAGRAM

figure_counter = figure_counter + 1;
fig1_comps.fig = figure(figure_counter);
hold on

% Bifurcation diagram
fig1_comps.p1 = plot(FP_Pm_List, FP_omega_List, 'HandleVisibility', 'off', 'DisplayName', 'Fixed Points', 'LineWidth', 1.5, 'Color', PS.Blue2);
fig1_comps.p2 = plot(FP_Pm_Bifurcation, FP_omega_Bifurcation, 'HandleVisibility', 'off', 'DisplayName', 'Saddle Node Bifurcation', 'LineStyle', 'none', 'LineWidth', .6, 'Marker', 'o', 'MarkerSize', 9, 'MarkerFaceColor', PS.DBlue1, 'MarkerEdgeColor' , PS.DBlue2);
fig1_comps.p3 = plot(LC_Pm_List, LC_omega_min_max, 'HandleVisibility', 'off', 'DisplayName', 'Stable Limit Cycle', 'LineStyle', 'none', 'LineWidth', .6, 'Marker', 'o', 'MarkerSize', 9, 'MarkerFaceColor', PS.Grey4, 'MarkerEdgeColor' , PS.DGrey4);
fig1_comps.p4 = plot(LC_Pm_Bifurcation, LC_omega_Bifurcation, 'HandleVisibility', 'off', 'DisplayName', 'Bifurcation', 'LineStyle', 'none', 'LineWidth', .6, 'Marker', 'o', 'MarkerSize', 9, 'MarkerFaceColor', PS.Red2, 'MarkerEdgeColor' , PS.DRed2);
fig1_comps.p5 = plot(LC_Pm_Bifurcation, min(LC_omega_Bifurcation), 'HandleVisibility', 'off', 'LineStyle', 'none', 'LineWidth', .6, 'Marker', 'o', 'MarkerSize', 9, 'MarkerFaceColor', PS.Yellow1, 'MarkerEdgeColor' , PS.DRed2);

% Darkest to Lightest
color_list = ["#EBF5FB", "#D6EAF8", "#AED6F1", "#85C1E9", "#5DADE2", "#3498DB", "#2E86C1", "#2874A6", "#21618C", "#1B4F72"];
color_list = ["#D6EAF8", "#AED6F1", "#85C1E9", "#5DADE2", "#3498DB", "#2E86C1", "#2874A6", "#21618C", "#1B4F72"];

color_list = [
% Blue
"#002331",
"#004663",
"#006994",
"#008cc6",
"#00b0f8",
"#32bff9",
"#66cffa",
"#99dffc",

% Green
"#002105",
"#01420a",
"#02630f",
"#038414",
"#04a519",
"#36b746",
"#68c975",
"#9adba3",

% Red
"#5b141e",
"#881e2e",
"#b6283d",
"#e4324d",
"#e95a70",
"#ee8494",
"#f4adb7",
"#f9d6db"
];


R = linspace(0, 255, length(mu_list)) / 255;
G = R;
B = R;
color_list = [];
for i = 1: length(mu_list)
    color_list = [color_list; [R(i), G(i), B(i)]];
end

legend_vec = [];

% Timeseries data
for k = length(mu_list):-1:1
    % Plot Trajectories
    fig1_comps.p6{k} = plot(PmSol{k}, omegaSol{k}, 'DisplayName', sprintf('$$\\mu=%.5f$$', mu_list(k)), 'LineWidth', 3, 'Color', color_list(k, :));
    fig1_comps.p7{k} = plot(PmSol{k}(1), omegaSol{k}(1), 'HandleVisibility', 'off', 'Marker', 'o', 'MarkerSize', 9, 'MarkerFaceColor', color_list(2, :), 'MarkerEdgeColor', color_list(1, :));

end

xlim([0.3, 0.75]);
ylim([-0.5, 4]);
hold off

% ADD LABELS, TITLE, LEGEND
% title('Bifurcation Diagram');
xlabel('$$P_{m}$$');
ylabel('$$\omega$$');

% % legend([fig1_comps.p1(1), fig1_comps.p2(1), fig1_comps.p3(1), fig1_comps.p4(1), fig1_comps.p6{1}, fig1_comps.p6{2}, fig1_comps.p6{3}, fig1_comps.p6{4}, fig1_comps.p6{5}], 'Fixed Points', 'Saddle Node Bifurcation', 'Stable Limit Cycle', 'Bifurcation', sprintf('$$\\mu=%.4f$$', mu_list(1)), sprintf('$$\\mu=%.4f$$', mu_list(2)), sprintf('$$\\mu=%.4f$$', mu_list(3)), sprintf('$$\\mu=%.4f$$', mu_list(4)), sprintf('$$\\mu=%.4f$$', mu_list(5)));
% legend([fig1_comps.p6{1}, fig1_comps.p6{2}, fig1_comps.p6{3}, fig1_comps.p6{4}, fig1_comps.p6{5}], sprintf('$$\\mu=%.4f$$', mu_list(1)), sprintf('$$\\mu=%.4f$$', mu_list(2)), sprintf('$$\\mu=%.4f$$', mu_list(3)), sprintf('$$\\mu=%.4f$$', mu_list(4)), sprintf('$$\\mu=%.4f$$', mu_list(5)));
% legend(legend_vec);
legend();

legendX = .27; legendY = .78; legendWidth = 0.01; legendHeight = 0.01;
fig1_comps.legendPosition = [legendX, legendY, legendWidth, legendHeight];

% ADD TEXT ON THE PLOT
xpos1 = FP_Pm_Bifurcation;
ypos1 = FP_omega_Bifurcation;
plotText1 = text(xpos1-0.07*xpos1, ypos1-0.15*(ypos1+1), sprintf('$$P_{m}=%0.4f$$', xpos1), 'Interpreter', 'latex', 'Color', PS.MyBlack, 'FontSize', PS.save_small_PlotTextFontSize);

xpos2 = LC_Pm_Bifurcation;
ypos2 = min(LC_omega_Bifurcation);
plotText2 = text(xpos2-.1*xpos2, ypos2+3.5*ypos2, sprintf('$$P_{m}=%0.4f$$', xpos2), 'Interpreter', 'latex', 'Color', PS.MyBlack, 'FontSize', PS.save_small_PlotTextFontSize);

% Standardize and save figure
STANDARDIZE_FIGURE(fig1_comps);
SAVE_MY_FIGURE(fig1_comps, 'Timeseries_with_Rate.png', 'small');


















