close all
corners=[0 0 10 10;0 10 0 10];
start=[8,1.5];
point1=[5,8];
point2=[2,5];
obstacles=[4 6 6 4 4;4 4 6 6 4];
plot(corners(1,:),corners(2,:),'*');
grid on 
hold on
plot(start(1),start(2),'*')
plot(point1(1),point1(2),'*')
plot(point2(1),point2(2),'*')
plot(obstacles(1,:),obstacles(2,:),'LineWidth',2);
%robot ³¯Ïò
rect=cse_276A_robot_ori(start,90);
plot([rect(1,:),start(1)],[rect(2,:),start(2)],'LineWidth',2);
%try to find the configuration space
configuration_spac0e=ones(100,100);
for i=40:60
    for j=40:60
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
        rect=cse_276A_robot_ori(point,0);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
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
figure(2)
imshow(configuration_spac0e)
configuration_spac30e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac30e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac30e(i,j)=0;
    end
end
configuration_spac30e=configuration_spac30e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,30);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac30e(i,j)=1;
        else
            configuration_spac30e(i,j)=0;
        end
    end
end
configuration_spac30e(80,85)=0;
configuration_spac30e=configuration_spac30e';
figure(3)
imshow(configuration_spac30e)
configuration_spac60e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac60e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac60e(i,j)=0;
    end
end
configuration_spac60e=configuration_spac60e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,60);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac60e(i,j)=1;
        else
            configuration_spac60e(i,j)=0;
        end
    end
end
configuration_spac60e(80,85)=0;
configuration_spac60e=configuration_spac60e';
figure(4)
imshow(configuration_spac60e)
configuration_spac90e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac90e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac90e(i,j)=0;
    end
end
configuration_spac90e=configuration_spac90e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,90);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac90e(i,j)=1;
        else
            configuration_spac90e(i,j)=0;
        end
    end
end
configuration_spac90e(80,85)=0;
configuration_spac90e=configuration_spac90e';
figure(5)
imshow(configuration_spac90e)
configuration_spac120e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac120e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac120e(i,j)=0;
    end
end
configuration_spac120e=configuration_spac120e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,120);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac120e(i,j)=1;
        else
            configuration_spac120e(i,j)=0;
        end
    end
end
configuration_spac120e(80,85)=0;
configuration_spac120e=configuration_spac120e';
figure(6)
imshow(configuration_spac120e)
configuration_spac150e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac150e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac150e(i,j)=0;
    end
end
configuration_spac150e=configuration_spac150e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,150);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac150e(i,j)=1;
        else
            configuration_spac150e(i,j)=0;
        end
    end
end
configuration_spac150e(80,85)=0;
configuration_spac150e=configuration_spac150e';
figure(7)
imshow(configuration_spac150e)
configuration_spac180e=ones(100,100);
for i=40:60
    for j=40:60
        configuration_spac180e(i,j)=0;
    end
end
for i=80:84
    for j=85:91
        configuration_spac180e(i,j)=0;
    end
end
configuration_spac180e=configuration_spac180e';
for i=1:100
    for j=100:-1:1
        point=[i/10,(100-j)/10];
        point_x=point(1,1);
        point_y=point(1,2);
        rect=cse_276A_robot_ori(point,180);
%         plot([rect(1,:),point_x],[rect(2,:),point_y],'LineWidth',2);
%         pause(0.05)
        point1_x=rect(1,2);
        point2_x=rect(2,2);
        point3_x=rect(1,3);
        point1_y=rect(2,3);
        point2_y=rect(1,4);
        point3_y=rect(2,4);
        point_in=1;
        if(point_x>4&&point_x<6)
           if(point_y>4&&point_y<6)
               point_in=0;
           end
        end
        point1_in=point1_x<=10&&point1_x>=0&&point1_y<=10&&point1_y>=0;
        if(point1_in)
           if(point1_x>=4&&point1_x<=6)
               if(point1_y>4&&point1_y<6)
                   point1_in=0;
               end
           end
        end
        point2_in=point2_x<=10&&point2_x>=0&&point2_y<=10&&point2_y>=0;
        if(point2_in)
           if(point2_x>=4&&point2_x<=6)
               if(point2_y>4&&point2_y<6)
                   point2_in=0;
               end
           end
        end
        point3_in=point3_x<=10&&point3_x>=0&&point3_y<=10&&point3_y>=0;
        if(point3_in)
           if(point3_x>=4&&point3_x<=6)
               if(point3_y>4&&point3_y<6)
                   point3_in=0;
               end
           end
        end
        if(point_in&&point1_in&&point2_in&&point3_in)
            configuration_spac180e(i,j)=1;
        else
            configuration_spac180e(i,j)=0;
        end
    end
end
configuration_spac180e(80,85)=0;
configuration_spac180e=configuration_spac180e';
figure(8)
imshow(configuration_spac180e)
configurations_space_combined=ones(100,100);
point1=[5,8];
point2=[2,5];
for i=1:100
    for j=1:100
        zero_=[configuration_spac0e(i,j),configuration_spac30e(i,j),configuration_spac60e(i,j),configuration_spac90e(i,j),configuration_spac120e(i,j),configuration_spac150e(i,j),configuration_spac180e(i,j)];
        if(0==min(zero_))
            configurations_space_combined(i,j)=0;
        end
    end
end
configurations_space_combined(50,20)=0;
configurations_space_combined(20,50)=0;
figure(9)
imshow(configurations_space_combined)
corners=[7,7,92,92 7;4,92,91,4 4];
convex_hull=[32 37 57 67 67 60 33 32 32;37 32 32 36 59 64 64 56 37];
corners(2,:)=100.-corners(2,:);
convex_hull(2,:)=100.-convex_hull(2,:);
corners=corners./10;
convex_hull=convex_hull./10;
figure(11)
plot(corners(1,:),corners(2,:),'*-')
hold on 
plot(convex_hull(1,:),convex_hull(2,:),'*-')
points_on_graph=zeros(2,1000);
number=0;
for i=0.7:0.1:9.2
    for j=0.8:0.1:9.6
        diatance1=abs(i-0.7);
        diatance2=abs(9.2-i);
        diatance3=abs(j-0.8);
        distance4=abs(9.6-j);
        min_=100000;
        for z=1:8
            distance=(i-convex_hull(1,z))^2+(j-convex_hull(2,z))^2;
            if distance<min_
                min_=distance;
            end
        end
        index=find(min([diatance1,diatance2,diatance3,distance4,min_])==[diatance1,diatance2,diatance3,distance4,min_]);
        size_=size(index);
        if size_(1,2)>1
            index=index(1,1);
        end
        if(index==5)
            min__=min([diatance1,diatance2,diatance3,distance4]);
            if abs(min_-min__)<=0.35
                number=number+1;
                points_on_graph(:,number)=[i;j];
            end 
        end
        switch index
            case 1
                plot(i,j,'r*');
            case 2
                plot(i,j,'g*');
            case 3
                plot(i,j,'b*');
            case 4
                plot(i,j,'y*')
            case 5
                plot(i,j,'m*')
        end
    end
end
plot(corners(1,:),corners(2,:),'*-b')
plot(convex_hull(1,:),convex_hull(2,:),'*-b')
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*b')
plot(point2(1),point2(2),'*b')
figure(12)
plot(points_on_graph(1,1:number),points_on_graph(2,1:number),'*');
hold on 
axis([0 10 0 10])
i=0:.1:2.5;
j=0:.1:2.5;
plot(i,j,'*');
i=7.5:.1:10;
j=7.5:.1:10;
plot(i,j,'*');
i=0:.1:2.5;
j=10:-.1:7.5;
plot(i,j,'*');
i=10:-.1:7.26;
j=0:.1:2.74;
plot(i,j,'*');
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*r')
plot(point2(1),point2(2),'*r')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
figure(13)
points_on_path=ones(2,number);
number1=0;
for i=1:number
    if(points_on_graph(2,i)>=-0.4038*points_on_graph(1,i)+5.6477)
        number1=number1+1;
        points_on_path(1,number1)=points_on_graph(1,i);
        points_on_path(2,number1)=points_on_graph(2,i);
    end
end
plot(points_on_path(1,1:number1),points_on_path(2,1:number1),'b*');
hold on 
axis([0 10 0 10])
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*r')
plot(point2(1),point2(2),'*r')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
i=linspace(7.1,8.1,20);
j=linspace(2.8,1.4,20);
plot(i,j,'b*')
points_on_path=points_on_path(:,1:number1);
points_on_path=[points_on_path,[i;j]];
points_on_path(1,:)=fliplr(points_on_path(1,:));
points_on_path(2,:)=fliplr(points_on_path(2,:));
dlmwrite('path_voronoi.txt', points_on_path);
%}
corners=[0.7000 0.7000 9.2000 9.2000 0.7000;9.6000 0.8000 0.9000 9.6000 9.6000];
figure(14)
plot(corners(1,:),corners(2,:),'*-b')
hold on 
plot(convex_hull(1,:),convex_hull(2,:),'*-b')
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*b')
plot(point2(1),point2(2),'*b')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
patch(convex_hull(1,:),convex_hull(2,:),'black')
M=zeros(15,15);
%start1 -> 13 point1 -> 14 point2 -> 15
for i=1:8
    distance=(start(1)-convex_hull(1,i))^2+(start(2)-convex_hull(2,i))^2;
    if distance<=27
        M(13,i)=distance;
        plot([start(1),convex_hull(1,i)],[start(2),convex_hull(2,i)],'k');
    end
end
for i=1:4
    distance=(start(1)-corners(1,i))^2+(start(2)-corners(2,i))^2;
    if distance<=70
        M(13,8+i)=distance;
        plot([start(1),corners(1,i)],[start(2),corners(2,i)],'k');
    end
end
for i=1:8
    distance=(point1(1)-convex_hull(1,i))^2+(point1(2)-convex_hull(2,i))^2;
    if distance<=15
        M(14,i)=distance;
        plot([point1(1),convex_hull(1,i)],[point1(2),convex_hull(2,i)],'k');
    end
end
for i=1:4
    distance=(point1(1)-corners(1,i))^2+(point1(2)-corners(2,i))^2;
    if distance<=50
        M(14,8+i)=distance;
        plot([point1(1),corners(1,i)],[point1(2),corners(2,i)],'k');
    end
end
for i=1:8
    distance=(point2(1)-convex_hull(1,i))^2+(point2(2)-convex_hull(2,i))^2;
    if distance<=15
        M(15,i)=distance;
        plot([point2(1),convex_hull(1,i)],[point2(2),convex_hull(2,i)],'k');
    end
end
for i=1:4
    distance=(point2(1)-corners(1,i))^2+(point2(2)-corners(2,i))^2;
    if distance<=50
        M(15,8+i)=distance;
        plot([point2(1),corners(1,i)],[point2(2),corners(2,i)],'k');
    end
end
plot(corners(1,:),corners(2,:),'k')
for i=1:4
    for j=1:8
        distance=(corners(1,i)-convex_hull(1,j))^2+(corners(2,i)-convex_hull(2,j))^2;
        distance_limit=42;
        if i==1
            distance_limit=distance_limit+10;
        end
        if distance<=distance_limit
            M(8+i,j)=distance;
            plot([corners(1,i),convex_hull(1,j)],[corners(2,i),convex_hull(2,j)],'k');
        end
    end
end
figure(15)
plot(corners(1,:),corners(2,:),'*-b')
hold on 
plot(convex_hull(1,:),convex_hull(2,:),'*-b')
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*b')
plot(point2(1),point2(2),'*b')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
patch(convex_hull(1,:),convex_hull(2,:),'black')
plot(corners(1,:),corners(2,:),'k')
plot([start(1),6.7],[start(2),6.4],'k');
plot([point1(1),6.7],[point1(2),6.4],'k');
plot([start(1),9.2],[start(2),9.6],'k');
plot([point1(1),9.2],[point1(2),9.6],'k');
figure(16)
plot(corners(1,:),corners(2,:),'*-b')
hold on 
plot(convex_hull(1,:),convex_hull(2,:),'*-b')
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*b')
plot(point2(1),point2(2),'*b')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
patch(convex_hull(1,:),convex_hull(2,:),'black')
plot(corners(1,:),corners(2,:),'k')
plot([point1(1),3.2],[point1(2),6.3],'k');
plot([point2(1),3.2],[point2(2),6.3],'k');
plot([point1(1),0.7],[point1(2),9.6],'k');
plot([point2(1),0.7],[point2(2),9.6],'k');
figure(17)
plot(corners(1,:),corners(2,:),'*-b')
hold on 
plot(convex_hull(1,:),convex_hull(2,:),'*-b')
plot(start(1),start(2),'*r')
plot(point1(1),point1(2),'*b')
plot(point2(1),point2(2),'*b')
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
patch(convex_hull(1,:),convex_hull(2,:),'black')
plot(corners(1,:),corners(2,:),'k')
plot([start(1),6.7],[start(2),6.4],'k');
plot([point1(1),6.7],[point1(2),6.4],'k');
plot([point1(1),3.2],[point1(2),6.3],'k');
plot([point2(1),3.2],[point2(2),6.3],'k');
x1=linspace(start(1),6.7,60);
y1=linspace(start(2),6.4,60);
x2=linspace(6.7,point1(1),30);
y2=linspace(6.4,point1(2),30);
x3=linspace(point1(1),3.2,30);
y3=linspace(point1(2),6.3,30);
x4=linspace(3.2,point2(1),25);
y4=linspace(6.3,point2(2),25);
x=[x1,x2,x3,x4];
y=[y1,y2,y3,y4];
points_on_path=[x;y];
figure(18)
plot(x,y,'*')
hold on 
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')
axis([0 10 0 10])
dlmwrite('path_visibility.txt', points_on_path);
for i=1:15
    for j=i+1:15
        M(i,j)=M(j,i);
    end
end
for i=1:15
    for j=1:15
        if M(i,j)==0
            M(i,j)=inf;
        end
    end
end
[distance1,path]=Dijk(M,13,14);
figure(19)
patch(convex_hull(1,:),convex_hull(2,:),'black')
hold on
plot(corners(1,:),corners(2,:),'-*')
plot([start(1),6.7],[start(2),6.4],'*');
plot([point1(1),6.7],[point1(2),6.4],'*');
plot([point1(1),3.2],[point1(2),6.3],'*');
plot([point2(1),3.2],[point2(2),6.3],'*');
plot([start(1),convex_hull(1,path(1,2))],[start(2),convex_hull(2,path(1,2))],'k');
plot([point1(1),convex_hull(1,path(1,2))],[point1(2),convex_hull(2,path(1,2))],'k');
axis([0 10 0 10])
[distance2,path]=Dijk(M,14,15);
plot([point2(1),convex_hull(1,path(1,2))],[point2(2),convex_hull(2,path(1,2))],'k');
plot([point1(1),convex_hull(1,path(1,2))],[point1(2),convex_hull(2,path(1,2))],'k');
distance=distance1+distance2;
disp('The smallest length: ');
disp(distance);
text(start(1),start(2),'starting point')
text(point1(1),point1(2),'point1')
text(point2(1),point2(2),'point2')