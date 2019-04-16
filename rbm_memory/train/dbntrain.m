function dbn = dbntrain(dbn, x, opts)
    n = numel(dbn.rbm);

    dbn.rbm{1} = rbmtrain(dbn.rbm{1}, x,opts);%x
	rbm=dbn.rbm{1};%
    disp('print parameters')
	fileName='E:/RBMW.mat';
	save(fileName,'rbm');

    for i = 2 : n
        
		if strcmp(opts.approx,'CD')            
            [h_samples,h_init]=sample_hiddens(dbn.rbm{i-1},opts,x);
            x=mag_hid_cd(dbn.rbm{i-1},opts,x,h_init);
			
% 			[h_samples_test,h_init_test]=samples_hidden(dbn.rbm{i-1},opts,test_x);
%             test_x=mag_hid_cd(dbn.rbm{i-1},opts,test_x,h_init_test);
            
        elseif strcmp(opts.approx,'tap2')
%             [h_samples,h_init]=samples_hidden(dbn.rbm{i-1},opts,x);
% 			m_vis=x;
% 			m_hid=h_init;
% 			m_vis = 0.5 * vis_tap2(dbn.rbm{i-1}, opts,m_vis, m_hid) + 0.5 * m_vis;
%             m_hid = 0.5 * hid_tap2(dbn.rbm{i-1}, opts,m_vis, m_hid) + 0.5 * m_hid;
% 			x=m_hid;
       
            [h_samples,h_init]=sample_hiddens(dbn.rbm{i-1},opts,x);
            m_vis = opts.equilibrate * mag_vis_tap2(dbn.rbm{i-1}, opts,x, h_init) + (1-opts.equilibrate) * x;
            x = opts.equilibrate * mag_hid_tap2(dbn.rbm{i-1}, opts,m_vis, h_init) + (1-opts.equilibrate) * h_init;
			
% 			[h_samples_test,h_init_test]=samples_hidden(dbn.rbm{i-1},opts,test_x);
%             m_vis_test = opts.equilibrate * mag_vis_tap2(dbn.rbm{i-j}, opts,test_x, h_init_test) + (1-opts.equilibrate) * test_x;
%             test_x = opts.equilibrate * mag_hid_tap2(dbn.rbm{i-j}, opts,m_vis_test, h_init_test) + (1-opts.equilibrate) * h_init_test;

        end
        dbn.rbm{i} = rbmtrain(dbn.rbm{i}, x, opts);
		
		switch num2str(i)
			case '2'
				W2=dbn.rbm{2};
				save(fileName, 'W2','-append');
			case '3'
				W3=dbn.rbm{3};
				save(fileName, 'W3','-append');
		end
    end

end
