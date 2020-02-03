import picar as pc
import time
pc.setup()
front=pc.front_wheels.Front_Wheels(db="config")
back=pc.back_wheels.Back_Wheels(db="config")
delay=0.005
back.forward()
speed=80
back.speed=speed
for i in range(0,150):
    time.sleep(delay)
front.turn_left()
back.backward()
for i in range(0,200):
    time.sleep(delay)
front.turn_straight()
for i in range(0,150):
    time.sleep(delay)
front.turn_left()
back.forward()
for i in range(0,230):
    time.sleep(delay)
front.turn_straight()
for i in range(0,150):
    time.sleep(delay)
back.backward()
for i in range(0,160):
    time.sleep(delay)
front.turn_left()
back.forward()
for i in range(0,220):
    time.sleep(delay)
front.turn_straight()
for i in range(0,160):
    time.sleep(delay)
back.backward()
for i in range(0,200):
    time.sleep(delay)
front.turn_left()
for i in range(0,100):
    time.sleep(delay)
front.turn_right()
for i in range(0,100):
    time.sleep(delay)
front.turn_straight()
for i in range(0,80):
    time.sleep(delay)
front.turn_left()
for i in range(0,150):
    time.sleep(delay)
front.turn_straight()
for i in range(0,60):
    time.sleep(delay)
back.stop()
time.sleep(10)
    

