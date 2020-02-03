function [sol_best] = cse276hw5_SA( dist_matrix,waypoints_x,waypoints_y)
a=0.999;   
t0=200;
tf=3;
t=t0;  
Markov_length=10000;  
amount=size(dist_matrix,1);
sol_new=1:amount;
E_current=inf;
E_best=inf; 
sol_current=sol_new;
sol_best=sol_new;  
p=1;
while t>=tf
    zz=0;
    for r=1:Markov_length
        if(rand<0.5)  
            ind1=0; ind2=0;
            while(ind1==ind2)
                ind1=ceil(rand.*amount);   
                ind2=ceil(rand.*amount);
            end
            tmp1=sol_new(ind1);
            sol_new(ind1)=sol_new(ind2);
            sol_new(ind2)=tmp1;   
        else
            ind1=0;ind2=0;ind3=0;
            while (ind1==ind2) || (ind2==ind3) || (ind3==ind1) || abs(ind1-ind2)==1
                ind1=ceil(rand.*amount);
                ind2=ceil(rand.*amount);
                ind3=ceil(rand.*amount);
            end
            tmp1=ind1;
            tmp2=ind2;
            tmo3=ind3;
            if  ind3<ind2 && ind1<ind3
                tmp2=ind2;ind2=ind3;ind3=tmp2;
            end
            if  ind1<ind2 && ind3<ind1
                tmp3=ind3;tmp1=ind1;tmp2=ind2;
                ind1=tmp3;ind2=tmp1;ind3=tmp2;
            end
            if ind2<ind3 && ind3<ind1 
                tmp3=ind3;tmp1=ind1;tmp2=ind2;
                ind1=tmp2;ind2=tmp3;ind3=tmp1;
            end
            if ind3<ind2 && ind2<ind1
                tmp3=ind3;tmp1=ind1;tmp2=ind2;
                ind1=tmp3;ind2=tmp2;ind3=tmp1;
            end
            if ind2<ind1 && ind1<ind3
                tmp1=ind1;tmp2=ind2;
                ind1=tmp2;ind2=tmp1;
            end
            
            temlist1=sol_new((ind1+1):(ind2-1));
            sol_new((ind1+1):(ind1+ind3-ind2+1))=sol_new((ind2):(ind3));
            sol_new((ind1+ind3-ind2+2):ind3)=temlist1;
        end
        E_new=0;
        for i=1:amount-1
             E_new=E_new+dist_matrix(sol_new(i),sol_new(i+1));
        end
        E_new=E_new+dist_matrix(sol_new(amount),sol_new(1));
        for l=1:52
            if sol_new(l) == l
                zz=1;            
            end
        end
         if E_new < E_current && zz==0
            E_current=E_new;
            sol_current=sol_new;
                if E_new < E_best
                     E_best=E_new;
                     sol_best=sol_new;
                end
        else
            if rand < exp(-(E_new-E_current)./t)
                E_current=E_new;
                sol_current=sol_new;
            else
                sol_new=sol_current;
            end
        end
    end
    t=t.*a; 
end
disp('The best solution:');
disp(sol_best);
disp('The shortest length:');
disp(E_best);
% % figure(20)
% han=eye(amount);
% coordinates=linspace(1,amount,amount)';
% coordinates=[coordinates,waypoints_y',waypoints_x'];
% for t=1:amount
%     han(t,sol_best(t))=1;
% end
% size(coordinates);
% size(han);
% gplot(han,coordinates,'-*');
end

