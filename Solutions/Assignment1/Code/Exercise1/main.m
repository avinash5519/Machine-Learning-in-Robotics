close all ;
clear ;

k=5 ;
par=Exercise1(k);

Simulate_robot(0.5, -0.03);
Simulate_robot(0,0.05);
Simulate_robot(1,0);
Simulate_robot(1,0.05);
Simulate_robot(-1,-0.05);