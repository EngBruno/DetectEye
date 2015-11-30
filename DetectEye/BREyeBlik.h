//
//  BREyeBlik.h
//  EyeBlinkBoard
//
//  Created by Bruno Roberto on 21/11/15.
//  Copyright © 2015 ifce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>
#import <opencv2/highgui/ios.h>
#import <opencv2/imgproc/imgproc.hpp>
#import <opencv2/objdetect/objdetect.hpp>
#include <opencv2/video/tracking.hpp>

#include <iostream>
#include <stdlib.h>
#include <stdio.h>

#include <math.h>
#include <vector>

#include <iomanip>
#include <chrono>
#include <ctime>
#include <thread>
#include <string.h>
#include <assert.h>
#include <float.h>
#include <limits.h>
#include <time.h>
#include <ctype.h>

using namespace std;
using namespace cv;

@interface BREyeBlik : NSObject<CvVideoCameraDelegate>{

}
@property(nonatomic,retain) CvVideoCamera* videoCamere;
@property BOOL flagBlinkEye;
-(void)starMagic:(UIImageView*)imgView;

@end
