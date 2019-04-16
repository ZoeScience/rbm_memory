function [vis_tap,vis_samples,hid_tap,hid_samples] = equilibrate(rbm,opts,m_vis,m_hid)
  
        for i = 1:opts.iterations 
            %%% for visible negative
            
            buf_vis=repmat(rbm.b', size(m_hid,1), 1) + m_hid * rbm.W;
            second_order_vis=((m_hid - abs(m_hid).^2) * rbm.W2) .* (0.5 - m_vis);
            buf_vis = buf_vis + second_order_vis;
            vis_tap = sigm(buf_vis);
            vis_samples = vis_tap > rand(size(vis_tap));
            
            %%% for hidden negative
            
            buf_hid = repmat(rbm.c', size(vis_samples,1), 1) + vis_samples * rbm.W';
            second_order_hid=(( vis_samples- abs(vis_samples).^2) * rbm.W2') .* (0.5 - m_hid);
            buf_hid = buf_hid + second_order_hid;
            hid_tap = sigm(buf_hid);
            hid_samples = hid_tap > rand(size(hid_tap));
            
            
        end
end