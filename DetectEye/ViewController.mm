//
//  ViewController.m
//  DetectEye
//
//  Created by Bruno on 23/11/15.
//  Copyright © 2015 Bruno. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.eyeBlink = [BREyeBlik alloc];
    [self.eyeBlink starMagic:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
