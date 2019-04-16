function [v_pos, h_pos, m_vis, m_hid]=iter_mag(rbm,opts,vis)
    v_pos = vis;
    h_pos = sigmrnd(repmat(rbm.c', size(vis,1), 1) + v_pos * rbm.W');
    
    if strcmp(opts.approx,'CD')
        mag_vis = @mag_vis_cd;
        mag_hid = @mag_hid_cd;
    elseif strcmp(opts.approx,'tap2')
        mag_vis = @mag_vis_tap2;
        mag_hid = @mag_hid_tap2;
    end
    
    m_vis = 0.5 * mag_vis(rbm, opts,vis, h_pos) + 0.5 * vis;
    m_hid = 0.5 * mag_hid(rbm, opts,m_vis, h_pos) + 0.5 * h_pos;
    
    for i = 1:1:opts.iterations-1
        m_vis = 0.5 * mag_vis(rbm, opts,m_vis, m_hid) + 0.5 * m_vis;
        m_hid = 0.5 * mag_hid(rbm, opts,m_vis, m_hid) + 0.5 * m_hid;
    end
end