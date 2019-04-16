function [vis_samples,vis_means]=sample_visibles(rbm,opts,hid_samples)
    vis_means = sigm(bsxfun(@plus,rbm.b',hid_samples * rbm.W));
    vis_samples= vis_means > rand(size(vis_means));
end