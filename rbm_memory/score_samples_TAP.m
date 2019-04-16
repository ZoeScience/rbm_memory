function score = score_samples_TAP(rbm,opts,vis)
    [v_pos,h_pos,m_vis,m_hid] = iter_mag(rbm,opts,vis);
    eps=1e-6;
    m_vis = max(m_vis, eps);
    m_vis = min(m_vis, 1.0-eps);
    m_hid = max(m_hid, eps);
    m_hid = min(m_hid, 1.0-eps);

    m_vis2 = m_vis.^2;
    m_hid2 = m_hid.^2;
    
         S= -sum(m_vis .* log(m_vis) + (1.0 - m_vis) .* log(1.0 - m_vis),2) - sum(m_hid .* log(m_hid) + (1.0 - m_hid) .* log(1.0 - m_hid),2);
         U_naive= - m_vis * rbm.b - m_hid * rbm.c - sum((m_vis * rbm.W') .* m_hid ,2);
         fe= free_energy(rbm,vis);
         Onsager= - 0.5 * sum(((m_vis-m_vis2) * rbm.W2') .* (m_hid - m_hid2),2);
         fe_tap=U_naive + Onsager - S;
         score= fe_tap - fe;
         
         
 %    end 
     
     
     

end