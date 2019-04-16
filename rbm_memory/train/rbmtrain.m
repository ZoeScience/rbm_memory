function rbm = rbmtrain(rbm, x, opts)
    assert(isfloat(x), 'x must be a float');
    assert(all(x(:)>=0) && all(x(:)<=1), 'all data in x must be in [0:1]');
    m = size(x, 1);
    numbatches = floor(m / opts.batchsize);
    [nh,nv]=size(rbm.W);   
    kk = randperm(m);
    
    for i = 1 : opts.numepochs
        
        err = 0;
        ll = 0;
        scoreTAP=0;
        recon_error=0;
        
%     if (i >= opts.iter_incr_begin) 
%   opts.iterations = opts.iterations+opts.iter_incr;
%     end
                
        for l = 1 : numbatches
            batch = x(kk((l - 1) * opts.batchsize + 1 : l * opts.batchsize), :);
            
            v_pos = batch;
            v_pos_sample = v_pos > rand(size(v_pos));
           % h_pos=sigm(repmat(rbm.c', opts.batchsize, 1) + v_pos_sample * rbm.W');
            h_pos=sigm( v_pos_sample * rbm.W');
            h_pos_sample = h_pos > rand(size(h_pos));
            
            rbm.W2 = rbm.W.^2;
            rbm.W3 = rbm.W.^3; 
                        

            if strcmp(opts.approx,'CD')     
                
                 for i = 1:opts.iterations
                     
                %        v_neg = sigm(repmat(rbm.b', opts.batchsize, 1) + h_pos_sample * rbm.W);
                        v_neg = sigm( h_pos_sample * rbm.W);
                        v_neg_sample = v_neg > rand(size(v_neg));
               %         h_neg = sigm(repmat(rbm.c', opts.batchsize, 1) + v_neg_sample * rbm.W'); 
                        h_neg = sigm( v_neg_sample * rbm.W'); 
                        h_neg_sample = h_neg > rand(size(h_neg));
                        
                 end
                                     
            elseif strcmp(opts.approx,'tap2') ||  strcmp(opts.approx,'tap3')
                     vis_init = v_pos_sample;
                     hid_init = h_pos_sample;
                     [vis_tap,vis_samples,hid_tap,hid_samples] = equilibrate(rbm,opts,vis_init,hid_init);
                     
                     v_neg = vis_tap;
                     v_neg_sample = vis_samples;
                     h_neg = hid_tap;
                     h_neg_sample = hid_samples;
            end
            

            rbm=calculate_weight_gradient(rbm,opts,v_neg,v_pos,h_neg,h_pos);
         %   rbm.vb = rbm.momentum * rbm.vb + rbm.alpha * sum(v_pos - v_neg)' / opts.batchsize;  % visible bias
         %   rbm.vc = rbm.momentum * rbm.vc + rbm.alpha * sum(h_pos - h_neg)' / opts.batchsize; % hidden bias
           
            
            rbm.W = rbm.W + rbm.vW;    
        %    rbm.b = rbm.b + rbm.vb;
        %    rbm.c = rbm.c + rbm.vc;
            
            if strcmp(opts.weight_decay,'l2')  %%%%%%%  regularization
                   rbm.vW = rbm.vW - rbm.alpha * opts.regularize * rbm.W;
            end
            if strcmp(opts.weight_decay,'l1')
                   rbm.vW = rbm.vW - rbm.alpha * opts.regularize * sign(rbm.W);
            end
            
            
            err = err + sum(sum((v_pos_sample - v_neg_sample) .^ 2)) / opts.batchsize;
    %        ll = ll + mean(persudoLL(rbm,v_pos))/(nh+nv);
    %        scoreTAP = scoreTAP + mean(score_samples_TAP(rbm,opts,v_pos))/(nh+nv);
 
         %%%%%%%%  mnist   
            if(l==1)

                figure(1);%
          %      dispims(v_pos_sample',28,28);
                 dispims(v_pos_sample(1:64,:)',8,8);

                figure(2);%
          %      dispims(v_neg_sample',28,28);
                 dispims(v_neg_sample',8,8);
                 
                figure(3);%
          %      dispims(v_neg_sample',28,28);
                 dispims(v_neg_sample(1:1,:)',8,8);

            end
            
         %%%%%%%%%% cifar10 or cifar 100  
%             if(l==1)
%                 
%                 visualize_rgb(uint8(v_pos*255),10,10);
%                 % visualize_rgb(uint8(v_pos(1:25,:)*255),5,5);
%                                                 
%                 %visualize_rgb(uint8(v_neg*255),10,10);
%                 visualize_rgb(uint8(v_neg(1:25,:)*255),5,5);
% 
%             end   
         


%             figure(3);
%             dispims(test_x(1:100,:)',28,28);
%             figure(4);
%             dispims(vneg(1:100,:)',28,28);
            
        end
        
        disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. Average reconstruction error is: ' num2str(err / numbatches)]);
    %    disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. Persudo Likelihoodis: ' num2str(ll / numbatches)]);
    %    disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. TAP: ' num2str(scoreTAP / numbatches)]);
%         disp(['epoch ' num2str(i) '/' num2str(opts.numepochs)  '. Recon Error test: ' num2str(recon_error_test)]);
        
        
%         if opts.numepochs > 5,
%            opts.momentum = opts.momentum + opts.incremomentum;
%         else
%            opts.momentum = opts.momentum;
%         end;
        
    end
       
    
%     [samples,means]=generate(rbm,opts,x); %%% hand-writing
%     figure; visualize(samples(1:100,:)');
    
    %generate(rbm,opts,x(1:10,:));
end











