function LL=persudoLL(rbm,vis)
    [n_samples,n_feat] = size(vis);
    vis_corrupted=vis;
    %idxs=round(rand(1,n_samples)*n_feat)+1;
    %idxs=randint(1,n_samples,[1 n_feat]);
    idxs=randint_s(1,n_samples,1,n_feat);
    for i=1:n_samples
        %for i =1:idxs(j)
        j=idxs(i);
        vis_corrupted(i,j) = 1 - vis_corrupted(i,j);
    end
    fe=free_energy(rbm,vis);
    fe_corrupted=free_energy(rbm,vis_corrupted);
    LL=n_feat * logsigm(fe_corrupted-fe);
end