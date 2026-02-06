
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
q_1=q_dot_th*pi*(r_2^2-r_1^2);
R_coolant=1/(2*pi*r_3*h);
R_graphite=(log(r_3/r_2)/(2*pi*k_gr));

T_2 = T_inf + q_1*(R_coolant + R_graphite);
T_3 = T_inf + q_1*R_coolant;









%xlabel('T_\infty')