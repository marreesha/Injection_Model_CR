load('matlab.mat');
load('out.mat');
R = 1.1; %сопротивление
L = 0.0002; %индукция магнитной катушки
n = 1900; %частота вращения коленчатого вала

d_c = 0.0032; 
A_v = (pi/4)*d_c^2;

b_b = 0.2; %коэф. демпфирования
K_v = 220000; %жесткость пружины
d_p = 0.0094; %диаметр камеры управления
A_p = (pi/4)*d_p^2; %площадь камеры управления
A_pis = (pi/4)*d_p^2; %прощадь поршня управления

A = 50;
B = -20;

m_a = 0.020; %масса привода
d_s = 0.0068; %диаметр иглы
d_n = 0.0094; %диаметр 
A_s = (pi/4)*d_s^2; %площадь иглы
A_n = (pi/4)*d_n^2; %площадь мультипликатора

rho = 832; %плотность топлива

b_n = 0.3; %коэф. демпфирования
K_n = 270000; %жесткость пружины
d_noz = 0.000247; %диаметр сопловых отверстий 
i_n = 9; %число сопловых отверстий
A_cyl = (pi*i_n/4)*d_noz^2; %суммарная площадь сопловых отверстий


C_di = 0.85;
d_i = 0.0032;
A_i = pi/4*d_i^2;

k = 0.96;

P_v = 5e5; 
P_t = 5; %fuel return pressure
P_rail = 1800; %rail pressure

Hv_max = 0.00052; %максимальный подъем поршня управления
m_sum = 0.032;%суммарная масса движущихся частей

angl = kamaz{1:720,1} - 180;
P_cyl = kamaz{1:720,2}; %Давление в цилиндре

V_inj = [0 0 60 60 40 40 0 0];
angl_inj = [150 166.5 166.6 169.4 169.5 180.2 180.3 200];
t = (1/(n/60))*2;

rate = out.Fuel;
dt = out.tout;
sum = 0;
supply_rate = out.supply_rate;
supply_rate_sum = 0;
injection_rate = out.injection_rate;
injection_rate_sum = 0;

for i = 2:length(rate)
    sum = sum + (dt(i)-dt(i-1))*(rate(i)+rate(i-1))/2;
    supply_rate_sum = supply_rate_sum + (dt(i)-dt(i-1))*...
        (supply_rate(i)+supply_rate(i-1))/2;
    injection_rate_sum = injection_rate_sum + (dt(i)-dt(i-1))*...
        (injection_rate(i)+injection_rate(i-1))/2;
end

angle = out.angle;
for i = 2:length(angle)
    if and(injection_rate(i) > 0, injection_rate(i-1) == 0) 
        angle1 = angle(i);
    elseif and(injection_rate(i) == 0, injection_rate(i-1) > 0)
        angle2 = angle(i);
    end
end

%%     
%     hold on;
%     grid on;
%     grid minor;
%     
%     plot(P_nuc(1:m,250), 'LineWidth', 1.4);
%     plot(P_nuc(1:m,400), 'LineWidth', 1.4);
%     plot(P_nuc(1:m,600), 'LineWidth', 1.4);
%     plot(P_nuc(1:m,250), 'LineWidth', 1.2);
%     plot(P_nuc(1:m,500), 'LineWidth', 1.2);
%      plot(P_nuc(m,1:n), 'LineWidth', 1.5);    
%     legend({' t = 282.5*10^{-5}',' t = 452*10^{-5}',' t = 678*10^{-5}'},'Location','northwest')
%     legend('boxoff')
%     xlabel('Number of Cell') 
%     xlabel('Time Step')
%     ylabel('Pressure, Pa')
%     ylabel('Piston Displacement, m')
%     hold off;

    