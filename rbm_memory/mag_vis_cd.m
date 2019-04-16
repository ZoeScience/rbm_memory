function cd=mag_vis_cd(rbm,opts,m_vis,m_hid)

    buf = repmat(rbm.b', size(m_hid,1), 1) + m_hid * rbm.W;

    cd = sigm(buf);
    
end