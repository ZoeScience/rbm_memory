close all;
load mnist_uint8;
% load('rbm_cd1');
% rbm= rbmStruct;
figure(1);
a=1000;
m=100;

% vis_init = train_x(a:a+m-1,:);
 vis_init = test_x(a:a+m-1,:);
%vis_init=vis_init+0.8*rand(size(vis_init));

vis_init_sample  = vis_init > rand(size(vis_init));

hid_init=sigm(repmat( rbm.c', m, 1) + vis_init_sample *rbm.W');
hid_init_sample = hid_init > rand(size(hid_init));

dispims(vis_init_sample',28,28);
%
opts.iterations = 450;

[v_neg, h_neg] = equilibrate(rbm,opts,vis_init_sample,hid_init_sample);
v_neg_sample = v_neg > rand(size(v_neg));

figure(2);
dispims(v_neg',28,28);
mean(sum((v_neg_sample-vis_init_sample).^2,2))