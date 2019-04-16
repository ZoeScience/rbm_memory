function rbm=calculate_weight_gradient(rbm,opts,v_neg,v_pos,h_neg,h_pos)
      v_neg_sample = v_neg > rand(size(v_neg));
      v_pos_sample = v_pos > rand(size(v_pos));
      
      c1 = h_pos' * v_pos_sample;
      c2 = h_neg' * v_neg_sample;
      vW = c1-c2;
      
      m1 = v_pos' * v_pos_sample;
      m2 = v_neg' * v_neg_sample;
            
      save('E://corelation_rbm_cd','m1','m2','c1','c2')
      
      if strcmp(opts.approx,'tap2') || strcmp(opts.approx,'tap3')
           %disp('tap2')
            buf2 = (h_neg-abs(h_neg).^2)' * (v_neg-abs(v_neg).^2) .* rbm.W; %100*784            
            vW = vW - rbm.alpha * buf2;  
            
            c3= buf2 + c2;
            c4 = buf2 + rbm.alpha * buf2;
            save('E://corelation_rbm_tap','c1','c3','c4','m1','m2')
            
      end
     
      rbm.vW = rbm.momentum * rbm.vW + rbm.alpha * vW  / opts.batchsize;
end