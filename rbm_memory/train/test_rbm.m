function test_rbm
addpath(genpath('../'));

%%%%%%% training on the MNIST

% load mnist_uint8;
% train_x = double(train_x) / 255;
% test_x  = double(test_x)  / 255;
% train_y = double(train_y);
% test_y  = double(test_y);

% load filter_train_1;
% train_x = double(filter_train_1)/255;

% load filter_train_2;
% train_x = double(filter_train_2)/255;

%%%%%%%% training on the 1d Ising model 

% load('s1 n64 rho1 mode_g j10000 W6.4e+08 Gap640 Cnf1e+06 d0 b0.1.mat')
% load('s1 n64 rho1 mode_g j10000 W6.4e+08 Gap640 Cnf1e+06 d0 b0.2.mat')
% load('s1 n64 rho1 mode_g j10000 W6.4e+08 Gap640 Cnf1e+06 d0 b0.5.mat')
% load('s1 n64 rho1 mode_g j10000 W6.4e+08 Gap640 Cnf1e+06 d0 b1.mat');
% load('s1 n64 rho1 mode_g j10000 W6.4e+08 Gap640 Cnf1e+06 d0 b2.mat')
% load('s1 n64 rho1 mode_g j0 W6.4e+08 Gap640 Cnf1e+06 d0 b3.mat')
% load('s1 n64 rho1 mode_g j0 W6.4e+08 Gap640 Cnf1e+06 d0 b4.mat')
% load('s1 n64 rho1 mode_g j0 W6.4e+08 Gap640 Cnf1e+06 d0 b10.mat')

% train_x = (double(cnfb')+eye(size(cnfb')))./2;
% train_x_uint = uint8(train_x);
% train_x = double(train_x_uint) / 255;

%%%%%%%%%% training on the 2d Ising model 
%  load('lattice_1.mat')
%  train_x = (double(lattice1)+eye(size(lattice1)))./2;
  
%  load('lattice_0.1.mat')
% train_x = (double(lattice01)+eye(size(lattice01)))./2;

 load('lattice_0.2.mat')
 train_x = (double(lattice0)+eye(size(lattice0)))./2;
%  
train_x_uint = uint8(train_x);
train_x = double(train_x_uint) / 255;


%%%%%%%%%%%% training to test the memory capacity
% load('train_data_20_all.mat');
% load('train_data_80_all.mat');
% load('train_data_80_2_all.mat');
%load('train_data_110_all.mat')

% train_x=double((1.0+train_x)/2);
% train_x = (double(train_x)+eye(size(train_x)))./2;
% train_x=uint8(train_x);
% train_x = double (train_x)/255;





%%  training details
rand('state',0);

% dbn.sizes = [500];
dbn.sizes = [64];
opts.numepochs = 3;
opts.batchsize = 100;
opts.momentum  =   0.5;
% opts.incremomentum = 0.5;
% opts.approx = 'tap2';
 opts.approx = 'CD';
opts.alpha     =   0.05; %
opts.regularize=0.00002; %  
opts.weight_decay='l2';
opts.iterations = 1;
opts.iter_incr = 0;
% opts.iter_incr_begin = 5;
%  dbn = dbnsetup(dbn, train_x(1:20000,:), opts);
%  dbn = dbntrain(dbn, train_x(1:20000,:), opts);
  dbn = dbnsetup(dbn, train_x, opts);
  dbn = dbntrain(dbn, train_x, opts);
%figure; visualize(dbn.rbm{1}.W(1:100,1:100)');
% dbn = dbnsetup(dbn, train_x(1:10000,:), opts);
% dbn = dbntrain(dbn, train_x(1:10000,:), opts);

figure(4);
% dispims(dbn.rbm{1}.W',28,28);
  dispims(dbn.rbm{1}.W',8,8);
figure(5);
% dispims(dbn.rbm{1}.W(1:1,:)',28,28);
  dispims(dbn.rbm{1}.W(1:1,:)',8,8);


    
