//
//  MainViewController.m
//  TextDemo
//
//  Created by DAWEI FAN on 07/03/2014.
//  Copyright (c) 2014 huiztech. All rights reserved.
//

#import "MainViewController.h"
#import <CoreMotion/CoreMotion.h>  
#define Height  [UIScreen mainScreen].bounds.size.height
#define SIZE 50
@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setBackGround
{
    UIView *view_Y=[[UIView alloc]initWithFrame:CGRectMake(140, 0, 40, self.view.frame.size.height)];
    view_Y.backgroundColor=[UIColor greenColor];
    [self.view addSubview:view_Y];
    
    UIView *view_X=[[UIView alloc]initWithFrame:CGRectMake(0, 220, 320,40)];
    view_X.backgroundColor=[UIColor greenColor];
   // [self.view addSubview:view_X];
    UIView *view_Z=[[UIView alloc]initWithFrame:CGRectMake(140,(Height-40)/2, 40,40)];
    view_Z.backgroundColor=[UIColor cyanColor];
    [self.view addSubview:view_Z];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackGround];
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(140, 0, 40, 40)];
    imageView.image=[UIImage imageNamed:@"glassBlueBall.png"];
    [self.view addSubview:imageView];
    baby=[[UIImageView alloc]initWithFrame:CGRectMake(0, 350, 55, 55)];
    baby.image=[UIImage imageNamed:@"baby.jpg"];
   // self.view.backgroundColor=[UIColor blueColor];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    if (!motionManager.accelerometerAvailable) {
        // fail code // 检查传感器到底在设备上是否可用
    }
    motionManager.accelerometerUpdateInterval = 0.01; // 告诉manager，更新频率是100Hz
  
    
    
    /*
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *latestAcc, NSError *error)
    {
        //2. Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等
        CMAccelerometerData *newestAccel = motionManager.accelerometerData;
        double accelerationX = newestAccel.acceleration.x;
        double accelerationY = newestAccel.acceleration.y;

        
        imageView.frame=CGRectMake(accelerationX*100 , accelerationY*100, 40, 40);
        NSLog(@"%f==%f\n",accelerationY,accelerationY);
        //通过陀螺仪模块可以实现模拟赛车，模拟射击等。
        [self.view addSubview:imageView];
        
    }];
    
    //*/
    NSLog(@"%f", Height);
    
    /* 加速度传感器开始采样，每次采样结果在block中处理 */
    // 开始更新，后台线程开始运行。
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         CMAccelerometerData *newestAccel = motionManager.accelerometerData;
         double accelerationX = newestAccel.acceleration.x;
         double accelerationY = newestAccel.acceleration.y;
         f.origin.x += (accelerationX * SIZE) * 1;
         f.origin.y += (accelerationY* SIZE) * -1;
         
         if(f.origin.x < 0)
             f.origin.x = 0;
         if(f.origin.y < 0)
             f.origin.y = 0;
        
         if(f.origin.x > (self.view.frame.size.width - f.size.width))
             f.origin.x = (self.view.frame.size.width - f.size.width);
         if(f.origin.y > (self.view.frame.size.height - f.size.height))
             f.origin.y = (self.view.frame.size.height - f.size.height);
         NSLog(@"%f==%f\n",f.origin.x ,f.origin.y);

         /* 运动动画 */
         [UIView beginAnimations:nil context:nil];
         [UIView setAnimationDuration:0.1];
 
        
          if(f.origin.y>=Height-40)
         {
            f.origin.y=Height-40;
         }
         imageView.frame=CGRectMake(140 ,f.origin.y, 40, 40);
         //通过陀螺仪模块可以实现模拟赛车，模拟射击等。
         [self.view addSubview:imageView];
         if(f.origin.y>=(Height-40)/2&&f.origin.y<=(Height+40)/2)
         {
             [self.view addSubview:baby];
           //  [NSThread sleepForTimeInterval:5.0];
             //
         }
         else
         {
               
             [baby removeFromSuperview];
         }
         [UIView commitAnimations];
         
     }];


    
/*
 
    //1. Accelerometer 获取手机加速度数据
    CMAccelerometerData *newestAccel = motionManager.accelerometerData;
    double accelerationX = newestAccel.acceleration.x;
    double accelerationY = newestAccel.acceleration.y;
    double accelerationZ = newestAccel.acceleration.z;
    
    //2. Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等
    double gravityX = motionManager.deviceMotion.gravity.x;
    double gravityY = motionManager.deviceMotion.gravity.y;
    double gravityZ = motionManager.deviceMotion.gravity.z;
    
    //获取手机的倾斜角度：
    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
    
    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;
    
    //zTheta是手机与水平面的夹角， xyTheta是手机绕自身旋转的角度
    
    //3. DeviceMotion 获取陀螺仪的数据 包括角速度，空间位置等
    //旋转角速度：
    CMRotationRate rotationRate = motionManager.deviceMotion.rotationRate;
    double rotationX = rotationRate.x;
    double rotationY = rotationRate.y;
    double rotationZ = rotationRate.z;
    
    //空间位置的欧拉角（通过欧拉角可以算得手机两个时刻之间的夹角，比用角速度计算精确地多）
    double roll    = motionManager.deviceMotion.attitude.roll;
    double pitch   = motionManager.deviceMotion.attitude.pitch;
    double yaw     = motionManager.deviceMotion.attitude.yaw;
    
    //空间位置的四元数（与欧拉角类似，但解决了万向结死锁问题）
    double w = motionManager.deviceMotion.attitude.quaternion.w;
    double wx = motionManager.deviceMotion.attitude.quaternion.x;
    double wy = motionManager.deviceMotion.attitude.quaternion.y;
    double wz = motionManager.deviceMotion.attitude.quaternion.z;  
    
    imageView.frame=CGRectMake(gravityX , gravityY, 40, 40);
    //通过陀螺仪模块可以实现模拟赛车，模拟射击等。
     [self.view addSubview:imageView];
    */
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
