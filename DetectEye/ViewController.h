//
//  ViewController.h
//  DetectEye
//
//  Created by Bruno on 23/11/15.
//  Copyright © 2015 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BREyeBlik.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) BREyeBlik *eyeBlink;
@end

