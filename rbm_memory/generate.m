function [samples,means]=generate(rbm,opts,vis_init)  %% 生成k次采样后的结果
    Nsamples = size(vis_init,1);
    Nhid= size(rbm.c,1);
    hid_init  = zeros(Nsamples,Nhid);
    %if approx=="naive" || contains(approx,"tap")
    if strcmp(opts.approx,'tap2') ||  strcmp(opts.approx,'tap3') ||  strcmp(opts.approx,'naive')
        [vis_mag, hid_mag] = equilibrate(rbm,opts,vis_init,hid_init);
        samples=vis_mag;
        means=samples;
    end
    if strcmp(opts.approx,'CD')
        [vis_samples, hid_mag, vis_means, hid_means] = MCMC(rbm, opts,vis_init,'visible');
        samples=vis_samples;
        means=samples;
    end

    %[samples,means] = sample_visibles(rbm,opts,hid_mag);
    %result=reshape(samples);
    %figure; visualize(samples);
    %visual(means(1:3,:));
end