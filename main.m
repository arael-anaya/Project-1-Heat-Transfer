
%Variables
k_th=57; %[W/m-K]
k_gr=3; %[W/m-K]
T_inf=600; %[K]
h=2000; %[W/(m^2*K)]
r_1=8/1000; %[m]
r_2=11/1000; %[m]
r_3=14/1000; %[m]
q_dot_th=linspace(1e8, 5e8,5); %[W/m^3]

%Calculations
q_1=q_dot_th*pi*(r_2^2-r_1^2); %[W/m] b/c cylinder length is unavailable
R_coolant=1/(2*pi*r_3*h); % [K*m/W] b/c cylinder length cancels
R_graphite=(log(r_3/r_2)/(2*pi*k_gr)); % [K*m/W] b/c cylinder length cancels

T_2 = T_inf + q_1*(R_coolant + R_graphite); % [K]; temperature between thorium rod & graphite
T_3 = T_inf + q_1*R_coolant; % [K]; temperature between graphite & coolant

r_th = linspace(r_1, r_2, 200);   % [m]

% Preallocate temperature matrix
T_th = zeros(length(q_dot_th), length(r_th));

for i = 1:length(q_dot_th)

    qth = q_dot_th(i);   % current volumetric heat generation [W/m^3]

    % Integration constants
    C1 = (qth/(2*k_th)) * r_1^2;
    C2 = T_2(i) + (qth/(4*k_th))*r_2^2-(qth/(2*k_th))*r_1^2*log(r_2);

    % Temperature distribution in thorium
    T_th(i,:) = ...
        -(qth/(4*k_th))*r_th.^2 ...
        + C1*log(r_th) ...
        + C2;
end

 
 


%Plotting



figure
hold on
grid on

ax = gca;
colors = ax.ColorOrder;   % MATLAB default color cycle

% Thorium region (continuous)
for i = 1:length(q_dot_th)
    color = colors(mod(i-1, size(colors,1)) + 1, :);

    plot(r_th*1000, T_th(i,:), ...
        'LineWidth', 2, ...
        'Color', color)

    % Graphite + coolant nodes
    plot([r_2, r_3]*1000, [T_2(i), T_3(i)],'LineWidth', 2, 'Color', color)
end

xlabel('Radius $r$ [mm]', 'Interpreter', 'latex')
ylabel('Temperature $T$ [K]', 'Interpreter', 'latex')
title('Radial Temperature Distribution $T(r)$', 'Interpreter', 'latex')

hold off
