//
//  SuperViewController.m
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "SuperViewController.h"

@interface SuperViewController ()

@end

@implementation SuperViewController

@synthesize topBar,bottomBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768/screenRatioX, 100/screenRatioY)];
    topBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:topBar];
    
    bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, (1024-100)/screenRatioY, 768/screenRatioX, 100/screenRatioY)];
    bottomBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomBar];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
