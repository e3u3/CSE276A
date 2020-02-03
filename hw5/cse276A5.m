%cse276A hw5 
%The first method
close all
corners=[0 0 10 10;0 10 0 10];
start=[8,1.5];
obstacle1=[2 4 4 2 2;2 2 4 4 2];
obstacle2=[7 8 8 7 7;7 7 8 8 7];
figure(1)
plot(corners(1,:),corners(2,:),'*');
grid on 
hold on
plot(start(1),start(2),'*')
plot(obstacle1(1,:),obstacle1(2,:),'LineWidth',2);
plot(obstacle2(1,:),obstacle2(2,:),'LineWidth',2);
%robot orientation
rect=cse_276A_robot_ori(start,60);
plot([rect(1,:),start(1)],[rect(2,:),start(2)],'LineWidth',2);
title('The simulated environment')
for index=1:7
    configuration_spac0e=ones(100,100);
    for i=20:40
        for j=20:40
            configuration_spac0e(i,j)=0;
        end
    end
    for i=70:80
        for j=70:80
            configuration_spac0e(i,j)=0;
        end
    end
    for i=80:84
        for j=85:91
            configuration_spac0e(i,j)=0;
        end
    end
    configuration_spac0e=configuration_spac0e';
    for i=1:100
        for j=100:-1:1
            point=[i/10,(100-j)/10];
            point_x=point(1,1);
            point_y=point(1,2);
            rect=cse_276A_robot_ori(point,0+30*(index-1));
    %         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
    %         pause(0.05)
            point1_x=rect(1,2);
            point2_x=rect(2,2);
            point3_x=rect(1,3);
            point1_y=rect(2,3);
            point2_y=rect(1,4);
            point3_y=rect(2,4);
            point_in=1;
            if(point_x>2&&point_x<4)
               if(point_y>2&&point_y<4)
                   point_in=0;
               end
            end
            if(point_x>7&&point_x<8)
               if(point_y>7&&point_y<8)
                   point_in=0;
               end
            end
            point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
            if(point1_in)
               if(point1_x>=2&&point1_x<=4)
                   if(point1_y>2&&point1_y<4)
                       point1_in=0;
                   end
               end
               if(point1_x>=7&&point1_x<=8)
                   if(point1_y>7&&point1_y<8)
                       point1_in=0;
                   end
               end
            end
            point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
            if(point2_in)
               if(point2_x>=2&&point2_x<=4)
                   if(point2_y>2&&point2_y<4)
                       point2_in=0;
                   end
               end
               if(point2_x>=7&&point2_x<=8)
                   if(point2_y>7&&point2_y<8)
                       point2_in=0;
                   end
               end
            end
            point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
            if(point3_in)
               if(point3_x>=2&&point3_x<=4)
                   if(point3_y>2&&point3_y<4)
                       point3_in=0;
                   end
               end
               if(point3_x>=7&&point3_x<=8)
                   if(point3_y>7&&point3_y<8)
                       point3_in=0;
                   end
               end
            end
            if(point_in&&point1_in&&point2_in&&point3_in)
                configuration_spac0e(i,j)=1;
            else
                configuration_spac0e(i,j)=0;
            end
        end
    end
    configuration_spac0e(80,85)=0;
    configuration_spac0e=configuration_spac0e';
%     figure(1+index)
%     imshow(configuration_spac0e)
    configuration_space{index}=configuration_spac0e;
end
configurations_space_combined=ones(100,100);
for i=1:100
    for j=1:100
        zero_=[configuration_space{1}(i,j),configuration_space{2}(i,j),configuration_space{3}(i,j),configuration_space{4}(i,j),configuration_space{5}(i,j),configuration_space{6}(i,j),configuration_space{7}(i,j)];
        if(0==min(zero_))
            configurations_space_combined(i,j)=0;
        end
    end
end
% figure(9)
% imshow(configurations_space_combined)
title('The configuration space')
%the start point(80,85) orientation 45
configuration_space_combined_origin=configurations_space_combined;
occupied=zeros(100,100);
restart=0;
iterations=0;
index=1;
total_areas=sum(sum(configuration_space_combined_origin));
while(1)
    if restart==0
        x_now=100-85;
        y_now=80;
    else
        x_now=round(rand*100);
        y_now=round(rand*100);
        while(x_now==100||x_now==0||y_now==100||y_now==0)
            x_now=round(rand*100);
            y_now=round(rand*100); 
        end
        while(configurations_space_combined(100-x_now,y_now)==0&&occupied(100-x_now,y_now)==0)
            x_now=round(rand*100);
            y_now=round(rand*100);
            while(x_now==100||x_now==0||y_now==100||y_now==0)
                x_now=round(rand*100);
                y_now=round(rand*100); 
            end
        end
    end
    occupied(100-x_now,y_now)=1;
    orientation=45;
    while(1)
        ori=orientation/45;
        switch ori
            case 0
                x_next=x_now;
                y_next=y_now+1;
            case 1
                x_next=x_now+1;
                y_next=y_now+1;
            case 2
                x_next=x_now+1;
                y_next=y_now;
            case 3
                x_next=x_now+1;
                y_next=y_now-1;
            case 4
                x_next=x_now;
                y_next=y_now-1;
            case 5
                x_next=x_now-1;
                y_next=y_now-1;
            case 6
                x_next=x_now-1;
                y_next=y_now;
            case 7
                x_next=x_now-1;
                y_next=y_now+1;
            case 8
                x_next=x_now;
                y_next=y_now+1;        
        end
        if configurations_space_combined(100-x_next,y_next)==0&&occupied(100-x_next,y_next)==0
            state=0;
            if configurations_space_combined(100-(x_now-1),y_now-1)==1
                state=1;
                orientation=225;
            else if configurations_space_combined(100-(x_now+1),y_now-1)==1
                    state=1;
                    orientation=135;
                else if configurations_space_combined(100-(x_now+1),y_now+1)==1
                        orientation=45;
                        state=1;
                        else if configurations_space_combined(100-(x_now-1),y_now+1)==1
                            orientation=315;
                            state=1;
                            end
                    end
                end
            end
            if state==0
                restart=restart+1;
                break;
            end
            %force to change a start point, like being kidnapped
        else
            configurations_space_combined(100-x_next,y_next)=0;
            iterations=iterations+1;
            if(mod(iterations,100)==0)
                ratio{index}=sum(sum(occupied))/total_areas;
                title_name=strcat('after ',int2str(index*100),' iterations');
%                 if mod(index,10)==0
% %                     figure(9+index/10)
% %                     imshow(configurations_space_combined)
% %                     title(title_name)
%                 end
                index=index+1;
            end
            x_now=x_next;
            y_now=y_next;
            occupied(100-x_now,y_now)=1;
        end
        if index==230 
            break;
        end
    end
    if index==230 
        break;
    end
end
index=index-1;
ratios_vector=ones(1,index);
for i=1:index
    ratios_vector(1,i)=ratio{i};
end
% figure(34)
% plot(ratios_vector)
% hold on
% grid on 
% title('Ratio of coverage versus iterations')
% ratios_half=0.5*ones(1,index);
% plot(ratios_half)
figure(10)
imshow(configuration_space_combined_origin);
configuration_space_combined_origina=configuration_space_combined_origin;
title('The configuration space')
number_waypoints=[100,300,500,700,900];
for z=1:5
    configuration_space_combined_origin=configuration_space_combined_origina;
    waypoints_x=zeros(1,number_waypoints(1,z));
    waypoints_y=zeros(1,number_waypoints(1,z));
    index=1;
    while(index<=number_waypoints(1,z))
         x_now=round(rand*100);
         y_now=round(rand*100);
         while(x_now==100||x_now==0||y_now==100||y_now==0)
             x_now=round(rand*100);
             y_now=round(rand*100);
         end
         while(configuration_space_combined_origin(100-x_now,y_now)==0)
             x_now=round(rand*100);
             y_now=round(rand*100);
             while(x_now==100||x_now==0||y_now==100||y_now==0)
                 x_now=round(rand*100);
                 y_now=round(rand*100);
             end
         end
         if index==1
            x_now=15;
            y_now=80;
         end
         waypoints_x(1,index)=x_now;
         waypoints_y(1,index)=y_now;
         configuration_space_combined_origin(100-waypoints_x(1,index),waypoints_y(1,index))=0;
         index=index+1;
    end
    figure(1+z)
    imshow(configuration_space_combined_origin)
    name=strcat(int2str(number_waypoints(1,z)),' waypoints(cities)');
    title(name);
    dist_matrix=zeros(number_waypoints(1,z),number_waypoints(1,z));
    for i=1:number_waypoints(1,z)
        point_x=waypoints_x(1,i);
        point_y=waypoints_y(1,i);
        for j=i+1:number_waypoints(1,z)
            point_x2=waypoints_x(1,j);
            point_y2=waypoints_y(1,j);
%             points_number=4;
%             points_x=round(linspace(point_x,point_x2,points_number));
%             points_y=round(linspace(point_y,point_y2,points_number));
            connectable=1;
%             for t=1:points_number
%                 if(configuration_space_combined_origina(100-points_x(1,t),points_y(1,t))==0&&100-points_x(1,t)~=15&&points_y(1,t)~=80)
%                     connectable=0;
%                     break;
%                 end
%             end
            if connectable==1
                dist_matrix(i,j)=sqrt((point_x-point_x2)^2+(point_y-point_y2)^2);
            else
                dist_matrix(i,j)=inf;
            end
        end
    end
    dist_matrix1=dist_matrix';
    dist_matrix=dist_matrix+dist_matrix1;
    sol_best=cse276hw5_SA(dist_matrix,waypoints_x,waypoints_y);
    figure(10+z)
    plot(waypoints_y,waypoints_x,'*');
    hold on
    text(80,15,'start point')
    for i=1:number_waypoints(1,z)-1
        plot([waypoints_y(1,sol_best(1,i)),waypoints_y(1,sol_best(1,i+1))],[waypoints_x(1,sol_best(1,i)),waypoints_x(1,sol_best(1,i+1))],'-k');
    end
    x1=[0,6,6,0];
    y1=[0,0,100,100];
    x2=[0,0,100,100];
    y2=[100,97,97,100];
    x3=[93,100,100,93];
    y3=[0,0,100,100];
    x4=[0,0,100,100];
    y4=[0,7,7,0];
    fill(x1,y1,'k')
    fill(x2,y2,'k')
    fill(x3,y3,'k')
    fill(x4,y4,'k')
    name=strcat(int2str(number_waypoints(1,z)),' waypoints(cities)');
    name=strcat('The shortest path for',32,name);
    title(name);
    distance{z}=dist_matrix;
end
%get the distance matrix
