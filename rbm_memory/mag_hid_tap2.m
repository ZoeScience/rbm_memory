function [hid_tap,hid_samples] = mag_hid_tap2(rbm,opts,m_vis,m_hid)
        buf=repmat(rbm.c', size(m_vis,1), 1) + m_vis * rbm.W';
        second_order=((m_vis - abs(m_vis).^2) * rbm.W2') .* (0.5 - m_hid);
        buf = buf + second_order;
        hid_tap = sigm(buf);
        hid_samples = hid_tap > rand(size(hid_tap));
      %return sigm(buf)
end