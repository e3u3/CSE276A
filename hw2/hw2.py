import numpy as np
import cv2
from pyzbar.pyzbar import decode
import sys 
import picar as pc
import time
from functools import reduce
#Landmark 1 is placed at point(-1,0)
#Landmark 2 is placed at point(-1,2)
#Landmark 3 is placed at point(0,1)
#Landmark goal is placed at point(0,-1)
motion_speed=0.32  #Within 0.5 second, the picar can move 0.16m -> motion speed=
#0.32m/s
class motion:
    def __init__(self,x,y,L,time_step):
        self.theta=0
        self.x=x
        self.y=y
        self.L=L
        self.time_step=time_step
    def forward(self,v,gamma,angle):
        back=pc.back_wheels.Back_Wheels(db='config')
        front=pc.front_wheels.Front_Wheels(db='config')
        back.backward()
        front.turn(angle)
        back.speed=80
        #print('before')
        #print('x:',self.x)
        #print('y:',self.y)
        #print('theta:',self.theta)
        time.sleep(self.time_step)   #every time, picar just moves for 0.5s and dose the QR detection for feedback control
        back.speed=0
        self.x+=self.time_step*(v*np.cos(self.theta))
        self.y+=self.time_step*(v*np.sin(self.theta))
        self.theta+=self.time_step*(v*np.tan(gamma)/self.L)
        #print('after')
        #print('x:',self.x)
        #print('y:',self.y)
        #print('theta:',self.theta)
def test(video_capture=False):
    count=0
    cap=cv2.VideoCapture(0)
    #print(video_capture)
    if video_capture==True:
        ret,frame=cap.read()
        if ret==True:
            size=frame.shape
        else:
            size=(0,0)
        width=size[1]
        height=size[0]
        size=(height,width)
        if size==(0,0):
            while(True):
                print("No image captured")
        #fourcc=cv2.cv.CV_FOURCC('M','J','P','G') this is for opencv2
        fourcc=cv2.VideoWriter_fourcc(*'XVID')  #this is for opencv3
        out=cv2.VideoWriter('output.avi',fourcc,20.0,size,True)
    x_difference_list=[]
    while(count<=10):
        ret,frame=cap.read()
        count+=1
        size=frame.shape
        width=size[1]
        height=size[0]
        if ret==True:
            #cv2.imshow('frame',frame)
            #print('video_capture:',video_capture)
            if video_capture==True:
                out.write(frame)    
            de=decode(frame)
            if de!=[]:
                info=de.pop(0)
                qr_data=info[0]
                qr_type=info[1]
                qr_rect=info[2]
                qr_polygon=info[3]
                point0=qr_polygon[0]
                point1=qr_polygon[1]
                point2=qr_polygon[2]
                point3=qr_polygon[3]
                #print(type(point0))
                #print(point0,point3)
                center_x=(point0.x+point1.x+point2.x+point3.x)/4
                center_y=(point0.y+point1.y+point2.y+point3.y)/4
                #print('center_x:',center_x)
                #print('center_y:',center_y)
                x_difference=center_x-width/2
                x_difference_list.append(x_difference)
                #print('x_difference:',x_difference)
            else:
                info="no QR code detected!"
            #print(info)
            #print(type(info))
            if cv2.waitKey(1)==27:
                break
        else:
            break
    cap.release()
    #print(x_difference_list)
    if x_difference_list!=[]:
        index=len(x_difference_list)
        x_difference=reduce(lambda x,y:x+y,x_difference_list)/index
        return x_difference
    else:
        return 'a'
def turn_angle(x_difference):
    #The purpose of this function is to get the tuning angle based on the x_difference
    go_straight=80   #When we set the angle to 80,the car could move forward
    k_angle=0.2
    gamma=x_difference*k_angle
    angle=go_straight+gamma
    return gamma,angle
def turn_right():   #when picar has reached the target point, it has to turn totally right to approcah the next target point
    front_wheel=pc.front_wheels.Front_Wheels(db='config')
    back_wheel=pc.back_wheels.Back_Wheels(db='config')
    front_wheel.turn(80)
    time.sleep(1)
    front_wheel.turn(130)
    back_wheel.backward()
    back_wheel.speed=80
    time.sleep(1.5)
    back_wheel.speed=0
    front_wheel.turn(80)
if __name__=='__main__':
    #print(sys.argv[1])   #string
    pi=3.14
    target=[[1,0,0],[1,2,pi],[0,2,1.5*pi],[0,0,0]]
    number=0
    isTrue=False
    isDebug=False
    picar_motion=motion(0,0,0.15,0.5)
    if len(sys.argv)>=2:
        isTrue=sys.argv[1]=="True"
        isDebug=sys.argv[2]=="True"
    picar_motion=motion(0,0,0.15,0.5)   #0.5 -> 0.5s for motion
                                        #after 0.5s, we detect the QR code
    while(number<=3):
        x_difference_average=test(isTrue)   #The position of QR code in the camera image
        if x_difference_average=='a':
            print('no QR code detected')
            picar_motion.forward(motion_speed,0,80)   #if no QR code detected, picar just moves forward
        else:
            #print('x_difference_average:',x_difference_average)
            gamma,angle=turn_angle(x_difference_average)
            print('gamma:',gamma)
            print('turn_angle:',angle)
            picar_motion.forward(motion_speed,gamma,angle) #After movement, the position and the orientation of picar has been updated
        position_x=picar_motion.x
        position_y=picar_motion.y
        theta=picar_motion.theta
        target_now=target[number]
        distance=np.sqrt((position_x-target_now[0])**2+(position_y-target_now[1])**2)
        print('distance:',distance)
        while(x_difference_average!='a'):
            x_difference_average=test(isTrue)   #The position of QR code in the camera image
            if x_difference_average=='a':
                print('no QR code detected')
                picar_motion.forward(motion_speed,0,80)   #if no QR code detected, picar just moves forward
            else:
                print('x_difference_average:',x_difference_average)
                gamma,angle=turn_angle(x_difference_average)
                print('gamma:',gamma)
                print('turn_angle:',angle)
                picar_motion.forward(motion_speed,gamma,angle) #After movement, the position and the orientation of picar has been updated
            position_x=picar_motion.x
            position_y=picar_motion.y
            theta=picar_motion.theta
            target_now=target[number]
            distance=np.sqrt((position_x-target_now[0])**2+(position_y-target_now[1])**2)
            print('distance:',distance)
        turn_right()
        number+=1




    

