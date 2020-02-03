function robot_shape = cse_276A_robot_ori( start,orientation )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    start_x=start(1);
    start_y=start(2);
    point1_x=start_x+0.39*sind(orientation);
    point1_y=start_y-0.39*cosd(orientation);
    point2_x=point1_x-0.65*cosd(orientation);
    point2_y=point1_y-0.65*sind(orientation);
    point3_x=start_x-0.65*cosd(orientation);
    point3_y=start_y-0.65*sind(orientation);
    robot_shape=[start_x point1_x point2_x point3_x;start_y point1_y point2_y point3_y];
end

