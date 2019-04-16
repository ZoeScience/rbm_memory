function r=visualize_rgb(X, s1, s2)
    [D,N]= size(X);%
    class(X)
    s=sqrt(D);%sample numbers

    if s==floor(s) || (s1 ~=0 && s2 ~=0)
        if (s1 ==0 || s2 ==0)
            s1 = s; s2 = s;
        end
        num=ceil(sqrt(N/3));%row and col
        %num
    %figure(1)
        figure();
%         for i=1:s1
%             for j=1:s2
%                 k=(i-1)*s1 + j
%                 A=reshape(X(k,:),num,num,3);
%             %size(A)
%                 %subplot(s1,s2,i),imagesc(A);
%                 left=(j-1)*0.09+0.005;
%                 bottom=i*0.09+0.005;
%                 width=0.09;
%                 height=0.09;
%                 %subplot('Position',[0.35 0.3 0.3 0.3]);
%                 subplot('Position',[left bottom width height]);
%                 imagesc(A);
%             end
%         end
        ppos = spp(ceil(sqrt(D)), ceil(sqrt(D)));
        for i = 1:D
            subplot('position', ppos(i,:));
            A=reshape(X(i,:),num,num,3);
            B = permute(A,[2 1 3]);
            imagesc(B);
            
            axis off;
        end
    end
end