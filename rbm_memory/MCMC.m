function [vis_samples, hid_samples, vis_means, hid_means]=MCMC(rbm, opts,v_pos_sample,h_pos_sample)
    iterations=opts.iterations;

    v_neg = sigm(repmat(rbm.b', opts.batchsize, 1) + h_pos_sample * rbm.W);
    v_neg_sample = v_neg > rand(size(v_neg));
    h_neg = sigm(repmat(rbm.c', opts.batchsize, 1) + v_neg_sample * rbm.W'); 
    h_neg_sample = h_neg > rand(size(h_neg));

%     if strcmp(StartMode,'visible')
%         vis_samples = v_init;
%         vis_means = v_init;
%         hid_means=sigm(bsxfun(@plus,rbm.c',vis_samples * rbm.W'));
%         hid_samples=binornd(1,hid_means,size(hid_means));
%     end
%     if strcmp(StartMode,'hidden')
%         hid_samples=h_init;
%         hid_means=h_init;
%         iterations = iterations + 1;
%     end
    
%         v_neg = v_init;
%         h_neg = h_init;

    for i = 1:iterations-1
        [hid_samples, hid_means] = sample_hiddens(rbm,opts,v_neg_samples);
        [vis_samples,vis_means] = sample_visibles(rbm,opts,v_neg_samples,h_neg_samples);
       
    end
end