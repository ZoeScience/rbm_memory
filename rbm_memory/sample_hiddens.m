function [samples,means]=sample_hiddens(rbm,opts,m_vis)

    
	% if strcmp(opts.approx,'CD') 
         means=sigm(bsxfun(@plus,rbm.c',m_vis * rbm.W'));
         samples= means > rand(size(means));

%    elseif strcmp(opts.approx,'tap2')
%         buf = bsxfun(@plus,rbm.c',m_vis * rbm.W');
%         second_order = ( (m_vis - m_vis.^2) * rbm.W2'  ) .* (0.5 - m_hid);
%         buf = buf + second_order;
%         cd_mean = sigm(buf);
% %        cd = sigmrnd(buf);		
%         cd=binornd(1,cd_mean,size(cd_mean));
% 
%     end 
   
end