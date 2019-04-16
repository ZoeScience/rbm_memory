function tap3 = mag_hid_tap3(rbm,opts,m_vis,m_hid)
      buf=repmat(rbm.c', size(m_vis,1), 1) + m_vis * rbm.W';
      second_order=((m_vis - abs(m_vis).^2) * rbm.W2') .* (0.5 - m_hid);
      third_order=( ( abs(m_vis).^2 .* (1 - m_vis) )  * rbm.W3')  .* (1/3 - 2* (m_hid - abs(m_hid).^2 ));
      buf = buf + second_order + third_order;
       tap3 = sigm(buf);
end