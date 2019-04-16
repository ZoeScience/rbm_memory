function tap3 = mag_vis_tap3(rbm,opts,m_vis,m_hid)
      buf=repmat(rbm.b', size(m_hid,1), 1) + m_hid * rbm.W;
      second_order=((m_hid - abs(m_hid).^2) * rbm.W2) .* (0.5 - m_vis);
      %size(m_hid)
      %size(rbm.W3)
      third_order= (    (  abs(m_hid).^2   .*  (1 - m_hid)   ) * rbm.W3 )   .* (1/3 - 2 * (m_vis - abs(m_vis).^2 ));
      buf = buf + second_order+third_order;
      tap3 = sigm(buf);
end