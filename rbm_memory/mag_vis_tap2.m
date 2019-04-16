function [vis_tap,vis_samples] = mag_vis_tap2(rbm,opts,m_vis,m_hid)
      %sigmrnd(sigmrnd(h1 * rbm.W);+ h1 * rbm.W);
      buf=repmat(rbm.b', size(m_hid,1), 1) + m_hid * rbm.W;
      second_order=((m_hid - abs(m_hid).^2) * rbm.W2) .* (0.5 - m_vis);
      buf = buf + second_order;
      vis_tap = sigm(buf);
      vis_samples = vis_tap > rand(size(vis_tap));
      %return sigm(buf)
end