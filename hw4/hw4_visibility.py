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
motion_steering_angle=17
motion_steering_angle_8=35
pi=np.pi
alpha=1.0/85   #1/85  ->  1m   1/168 -> 0.5m  u=1/85*(y*)
belta=700    #-0.2m ->  -138   0.3m -> 217  v=700*(x*)
state_vector=np.zeros([27,1],float)
state_vector[0,0]=0
state_vector[1,0]=0
state_vector[2,0]=pi/2
state_vector=np.matrix(state_vector)
#the initial value for state vector
convariance_matrix=np.eye(27)  #the initial value for convariance matrix at time 0
convariance_matrix=np.matrix(convariance_matrix)
noise_matrix_motion=np.hstack([np.random.rand(3,3),np.zeros([3,24],float)])
noise_matrix_motion=np.vstack([noise_matrix_motion,np.zeros([24,27],float)]) #noise matrix for motion prediction
noise_matrix_motion=np.matrix(noise_matrix_motion)
noise_matrix_measurement=np.random.rand(2,2)
noise_matrix_measurement=np.matrix(noise_matrix_measurement)
g_matrix=np.eye(27)  #g matrix 
g_matrix=np.matrix(g_matrix)
h_matrix=np.zeros([2,27],float)  #h matrix
h_matrix=np.matrix(h_matrix)
index=0   #which QR code out robot is seeing
class motion:
    def __init__(self,L,time_step):
        self.L=L
        self.time_step=time_step
    def circle(self,v,gamma,angle):  #move in a circle
        global state_vector
        global convariance_matrix
        global g_matrix
        global noise_matrix_motion
        back=pc.back_wheels.Back_Wheels(db='config')
        front=pc.front_wheels.Front_Wheels(db='config')
        back.backward()
        front.turn(angle)
        back.speed=0
        time.sleep(self.time_step)   #every time, picar just moves for 0.5s and dose the QR detection for feedback control
        back.speed=0
        #this part is about the motion prediction in EKF
        state_vector_update=np.zeros([27,1],float)
        state_vector_update[0,0]=self.time_step*(v*np.cos(state_vector[2,0]))
        state_vector_update[1,0]=self.time_step*(v*np.sin(state_vector[2,0]))
        state_vector_update[2,0]=-self.time_step*(v*np.tan(gamma)/self.L)
        g_matrix[0,2]=v*self.time_step*v*np.tan(gamma)*(-np.sin(state_vector[2,0]))/self.L
        g_matrix[1,2]=v*self.time_step*v*np.tan(gamma)*(np.cos(state_vector[2,0]))/self.L
        state_vector=state_vector+state_vector_update
        convariance_matrix_prediction=g_matrix*convariance_matrix*g_matrix.T+noise_matrix_motion
        if(state_vector[2,0]<=-1*pi):
            state_vector[2,0]=2*pi+state_vector[2,0]
        time.sleep(self.time_step/2)
        #print('state_vector:',state_vector.T)
        return convariance_matrix_prediction
def camera(video_capture=False):
    global alpha
    global belta
    global index
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
    v_list=[]   #the difference between center of landmark and center of image
    u_list=[]   #the width of landmark
    while(count<=10):
        ret,frame=cap.read()
        count+=1
        size=frame.shape
        width=size[1]
        height=size[0]
        if ret==True:
            cv2.imshow('frame',frame)
            #print('video_capture:',video_capture)
            if video_capture==True:
                out.write(frame)    
            de=decode(frame)
            print(de)
            if de!=[]:
                info=de.pop(0)
                qr_data=info[0]
                qr_type=info[1]
                qr_rect=info[2]
                qr_polygon=info[3]
                width_of_landmark=qr_rect[2]
                point0=qr_polygon[0]
                point1=qr_polygon[1]
                point2=qr_polygon[2]
                point3=qr_polygon[3]
                center_x=(point0.x+point1.x+point2.x+point3.x)/4
                center_y=(point0.y+point1.y+point2.y+point3.y)/4
                v=center_x-width/2
                u=1.0/width_of_landmark
                float(u)
                v_list.append(v)
                u_list.append(u)
                print('v:',v)
                print('u:',u)
            if cv2.waitKey(1)==27:
                break
        else:
            break
    cap.release()
    if u_list!=[]:
        number=len(u_list)
        u=reduce(lambda x,y:x+y,u_list)/number
        v=reduce(lambda x,y:x+y,v_list)/number
        index+=1
        if index>12:
            index=0
        result=[u,v]
        return result
    else:
        return 'a'
def motion_visibility():
    front=pc.front_wheels.Front_Wheels(db="config")
    back=pc.back_wheels.Back_Wheels(db="config")
    delay=0.003
    speed=80
    back.speed=speed
    front.turn_left()
    back.backward()
    for i in range(0,200):
        time.sleep(delay)
    front.turn_straight()
    for i in range(0,300):
        time.sleep(delay)
    front.turn_right()
    for i in range(0,50):
        time.sleep(delay)
    front.turn_straight()
    for i in range(0,200):
        time.sleep(delay)
    front.turn_left()
    for i in range(0,200):
        time.sleep(delay)
    front.turn_straight()
    for i in range(0,300):
        time.sleep(delay)
    front.turn_left()
    for i in range(0,750):
        time.sleep(delay)
    front.turn_straight()
    for i in range(0,400):
        time.sleep(delay)
    back.stop()
def measurement_update(u,v):
    global state_vector
    global convariance_matrix
    global h_matrix
    global alpha
    global belta
    global index
    index_in_matrix=2+2*index-1
    y_robot=u/alpha
    x_robot=v/belta
    x_world=np.sin(state_vector[2,0])*x_robot+np.cos(state_vector[2,0])*y_robot+state_vector[0,0]
    y_world=-np.cos(state_vector[2,0])*x_robot+np.sin(state_vector[2,0])*y_robot+state_vector[1,0]
    state_vector[index_in_matrix,0]=x_world
    state_vector[index_in_matrix+1,0]=y_world
    h_matrix[0,0]=-alpha
    h_matrix[1,1]=-belta
    h_matrix[0,2]=alpha*state_vector[index_in_matrix,0]*np.cos(state_vector[2,0])+alpha*state_vector[index_in_matrix+1,0]*np.sin(state_vector[2,0])
    h_matrix[1,2]=-belta*state_vector[index_in_matrix,0]*np.cos(state_vector[2,0])+belta*state_vector[index_in_matrix+1,0]*np.cos(state_vector[2,0])
    h_matrix[0,index_in_matrix]=alpha*np.sin(state_vector[2,0])
    h_matrix[1,index_in_matrix]=belta*np.cos(state_vector[2,0])
    h_matrix[0,index_in_matrix+1]=-alpha*np.cos(state_vector[2,0])
    h_matrix[1,index_in_matrix+1]=belta*np.sin(state_vector[2,0])
    K_gain=convariance_matrix*h_matrix.T*np.linalg.inv(h_matrix*convariance_matrix*h_matrix.T+noise_matrix_measurement)
    x_robot_=state_vector[index_in_matrix,0]*np.sin(state_vector[2,0])-state_vector[index_in_matrix+1,0]*np.cos(state_vector[2,0])-state_vector[0,0]
    y_robot_=state_vector[index_in_matrix,0]*np.cos(state_vector[2,0])+state_vector[index_in_matrix+1,0]*np.sin(state_vector[2,0])-state_vector[1,0]
    u_=alpha*x_robot_
    v_=belta*y_robot_
    measurement_diff=np.matrix([u-u_,v-v_]).T
    state_vector+=K_gain*measurement_diff
    convariance_change_matrix=np.eye(27)-K_gain*h_matrix
    convariance_matrix=convariance_change_matrix*convariance_matrix
if __name__=='__main__':
    #print(sys.argv[1])   #string
    number=0
    isTrue=False
    isDebug=False
    if len(sys.argv)>=2:
        isTrue=sys.argv[1]=="True"
        isDebug=sys.argv[2]=="True"
    picar_motion=motion(0.15,0.5)   #0.5 -> 0.5s for motion
                                        #after 0.5s, we detect the QR code
    while(number<=14):
         motion_visibility()
         #convariance_matrix=picar_motion.circle(motion_speed,pi*motion_steering_angle/180,80+motion_steering_angle)
         #Trajectory_8:
         if number<=7:
             convariance_matrix=picar_motion.circle(motion_speed,pi*motion_steering_angle_8/180,80+motion_steering_angle_8)
         else:
             convariance_matrix=picar_motion.circle(motion_speed,pi*(-1)*motion_steering_angle_8/180,80-motion_steering_angle_8)
         measurement=camera()
         if(measurement=='a'):
            print('No QR code detected!')
         else:
            u=measurement[0]
            v=measurement[1]
            measurement_update(u,v)
         number+=1
         print('state_vector:',state_vector)
         print('convariance_matrix',convariance_matrix)
    np.savetxt("state_8.txt",state_vector)
    np.savetxt("conva_8.txt",convariance_matrix)
#    print(state_vector,file=state_vector_data)
#    print(convariance_matrix,file=convariance_matrix_data)



    

