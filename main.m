
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
%T_1 is not shown b/c it'sthe temperature between the thorium rod & insulation

%Plotting
r = [r_2*1000, r_3*1000]; %Convert into vector and m to mm for plotting purposes
T = [T_2; T_3]; %Convert into vector for plotting purposes

figure
plot(r, T, 'LineWidth', 2)
grid on

xlabel('Radius $r$ [mm]', 'Interpreter', 'latex')
ylabel('Temperature $T$ [K]', 'Interpreter', 'latex')
title('Temperature vs Radius', 'Interpreter', 'latex')
