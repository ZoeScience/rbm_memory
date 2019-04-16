function [mse,v_neg] = reconstruction_error(rbm,opts,test_x)
     
    v_pos = test_x;
    v_pos_sample = v_pos > rand(size(v_pos));
	h_pos=sigm(repmat(rbm.c', size(test_x,1), 1) + v_pos_sample * rbm.W');%for 
    h_pos_sample = h_pos > rand(size(h_pos));
	

	 if strcmp(opts.approx,'CD')
% 			 vis_init = v_pos;
% 			 hid_init = h_samples;
% 			 [v_neg, h_samples1, v_means1, h_neg] = MCMC(rbm, opts,vis_init,hid_init,'hidden');
             
            v_neg = sigm(repmat(rbm.b', size(test_x,1), 1) + h_pos_sample * rbm.W);
        %    v_neg_sample = v_neg > rand(size(v_neg));
            h_neg = sigm(repmat(rbm.c', size(test_x,1), 1) + v_neg * rbm.W'); 
	 elseif strcmp(opts.approx,'tap2') ||  strcmp(opts.approx,'tap3')   ||  strcmp(opts.approx,'naive') 
			 vis_init = v_pos;
			 hid_init = h_pos;
			 [v_neg, h_neg] = equilibrate(rbm,opts,vis_init,hid_init);
     end
     
	 mse = sum(sum((v_pos - v_neg) .^ 2));
     
%      if(size(test_x,1)>1000)
%          figure(3);
%         dispims(v_pos_sample(1:100,:)',28,28);
%         figure(4);
%         dispims(v_neg_sample(1:100,:)',28,28);
%      end
end