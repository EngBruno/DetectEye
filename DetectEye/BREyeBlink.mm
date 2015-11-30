//
//  BREyeBlik.m
//  EyeBlinkBoard
//
//  Created by Bruno Roberto on 21/11/15.
//  Copyright © 2015 ifce. All rights reserved.
//

#import "BREyeBlink.h"

@implementation BREyeBlink{
    CascadeClassifier faceCascade;
    CascadeClassifier eyes_cascade;
    CascadeClassifier nose_cascade;
    Mat frame_gray,eyeCenter;
    std::vector<cv::Rect> faces;
    std::vector<cv::Rect> eyes;
     std::vector<cv::Rect> nose;
    int numberTimerBlink;
//    bool flagBlinkEye;
}

-(void)starMagic:(UIImageView *)imgView{
    
    NSString* faceCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt2" ofType:@"xml"];
    faceCascade.load([faceCascadePath UTF8String]);
    
    //NSString* eyes_cascade_name = [[NSBundle mainBundle] pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"];
    NSString* eyes_cascade_name = [[NSBundle mainBundle]  pathForResource:@"haarcascade_lefteye_2splits" ofType:@"xml"];
    eyes_cascade.load([eyes_cascade_name UTF8String]);

    //NSString* eyes_cascade_name = [[NSBundle mainBundle] pathForResource:@"haarcascade_eye_tree_eyeglasses" ofType:@"xml"];
    NSString* nose_cascade_name = [[NSBundle mainBundle]  pathForResource:@"Nariz" ofType:@"xml"];
    nose_cascade.load([nose_cascade_name UTF8String]);
    
    // Do any additional setup after loading the view, typically from a nib.
    self.videoCamere = [[CvVideoCamera alloc] initWithParentView:imgView];
    self.videoCamere.delegate = self;
    self.videoCamere.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamere.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamere.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamere.rotateVideo = YES;
    self.videoCamere.defaultFPS = 30;
    [self.videoCamere start];
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(Mat&)image{
    cvtColor( image, frame_gray, CV_BGRA2GRAY );
    equalizeHist( frame_gray, frame_gray );
    
    
    //-- Detect nose
    faceCascade.detectMultiScale( frame_gray, faces, 1.1, 2, CV_HAAR_FIND_BIGGEST_OBJECT | CV_HAAR_DO_ROUGH_SEARCH, cv::Size(30, 30) );
    for( size_t i = 0; i < faces.size(); i++ ){
        cv::Point center( faces[0].x + faces[0].width*0.5, faces[0].y + faces[0].height*0.5 );
        ellipse( image, center, cv::Size( faces[0].width*0.5, faces[0].height*0.5), 0, 0, 360, Scalar( 255, 0, 255 ), 4, 8, 0 );
        [self detect_eyes:image];
        
    }

//    if (faces.size()>0 && nose.size()>0) {
//        if (numberTimerBlink>6) {
//            printf("Piscou-> %d\n", numberTimerBlink);
//            self.flagBlinkEye = YES;
//        }else{
//            self.flagBlinkEye = NO;
//        }
//
//    }
}

/**
 * Given an image, this function will detect human eyes on the image and
 * draws green boxes around them.
 */
-(void) detect_nose:(Mat&)image{
    Mat faceROI = image(faces[0]);
    //-- In each face, detect eyes
    nose_cascade.detectMultiScale( faceROI, nose, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, cv::Size(30, 30) );
    if( nose.size()>0){
        cv::Point center( faces[0].x + nose[0].x + nose[0].width*0.5, faces[0].y + nose[0].y + nose[0].height*0.5 );
        float radius = cvRound( (nose[0].width + nose[0].height)*0.25 );
        circle(image, center, radius/2, Scalar( 255, 255, 255 ));
        [self detect_eyes:image];
    }
}

/**
 * Given an image, this function will detect human eyes on the image and
 * draws green boxes around them.
 */
-(void) detect_eyes:(Mat&)image{
    Mat faceROI = image(faces[0]);
    //-- In each face, detect eyes
    eyes_cascade.detectMultiScale( faceROI, eyes, 1.1, 2, 0 |CV_HAAR_SCALE_IMAGE, cv::Size(30, 30) );
    for( size_t j = 0; j < eyes.size(); j++ ){
        
        cv::Point center( faces[0].x + eyes[0].x + eyes[0].width*0.5, faces[0].y + eyes[0].y + eyes[0].height*0.5 );
        float radius = cvRound( (eyes[0].width + eyes[0].height)*0.25 );
        cv::Rect rectEye(center.x-radius/2,center.y-radius/2,20,20);
        rectangle(image, rectEye, Scalar( 25, 24, 1 ));
        
    }
    
    if (eyes.size()==0) {
        numberTimerBlink++;
    }else{
        numberTimerBlink=0;
        self.flagBlinkEye = NO;
    }
}
#endif
@end
