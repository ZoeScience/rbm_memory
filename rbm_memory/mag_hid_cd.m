function [cd,cd_mean]=mag_hid_cd(rbm,opts,m_vis,m_hid)
    
    buf=repmat(rbm.c', size(m_vis,1), 1) + m_vis * rbm.W';

    cd = sigm(buf);
    
end