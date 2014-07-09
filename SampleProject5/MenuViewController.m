//
//  MenuViewController.m
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "MenuViewController.h"
#import "UIButton+CustomButton.h"


@interface MenuViewController ()

@end

id viewControllerObject;


@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithDelegate:(id)delegate{
    if(self != NULL){
        self = [super init];
    }
    
    viewControllerObject = delegate;
    return self;
}

- (void)viewDidLoad
{
    self.view.frame = CGRectMake(0, 0, 768/screenRatioX, 1024/screenRatioY);
    
    //UIButton *btn = [UIButton buttonItemWithImage:[UIImage imageNamed:@"radioButtonON.png"] target:viewControllerObject action:@selector(play) position:CGRectMake(50, 50, 50, 50) tag:0];
    
    UIButton *btn = [UIButton buttonItemWithText:@"Play" textColor:[UIColor redColor] fontSize:20 target:viewControllerObject action:@selector(play) position:CGRectMake((568/2)/screenRatioX, (974/2)/screenRatioY, 100,50) tag:5];
    
    [self.view addSubview:btn];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
