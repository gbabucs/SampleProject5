//
//  ViewController.m
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "ViewController.h"
#import "QuestionViewController.h"
#import "FileManager.h"

@interface ViewController ()

@end

QuestionViewController *QuestionPage;
DownloadData *down;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    screenRatioX = 768/self.view.frame.size.width;
    screenRatioY = 1024/self.view.frame.size.height;
    
    menu = [[MenuViewController alloc] init];
    [self.view  addSubview:menu.view];
    
    QuestionPage = [QuestionViewController sharedManager:self];
    
    down = [[DownloadData alloc] init];

    //check the storedchecksum and server side check sun
    isDownLoadingINprogress = YES;
    
    [down downloadWithNsurlconnection:^(float processUnit, NSString *receivedData) {
        if(processUnit >= 1.0){
            NSError *error = NULL;
            
            NSDictionary *settingsDic = [NSJSONSerialization JSONObjectWithData:[receivedData dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            fileName = [settingsDic objectForKey:@"filename"];
            
            
             NSString *jsonString = [[FileManager sharedManager] readFile:@"settings.json"];
            
            if(jsonString){
                NSLog(@"json:%@",jsonString);
                
                NSData* data = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
                error = NULL;
                
                NSMutableDictionary *storedDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                
                if([[settingsDic objectForKey:@"checksum"]intValue] != [[storedDictionary objectForKey:@"checksum"]intValue]){
                    BOOL isWrite = [[FileManager sharedManager] writeFile:@"settings.json" fileContent:receivedData];
                    
                    [self triggerQuizDownload];
                    
                    if(!isWrite){
                        NSLog(@"Failed create file");
                    }
                }
            }
            else{
                BOOL isWrite = [[FileManager sharedManager] writeFile:@"settings.json" fileContent:receivedData];                
                [self triggerQuizDownload];
                
                if(!isWrite){
                    NSLog(@"Failed create file");
                }
            }
            
            isDownLoadingINprogress = NO;
        }
    } urlString:@"http://tyrogames.com/FootyQuiz/settings.json"];
    
}

- (void) triggerQuizDownload{
    
    
    [down downloadWithNsurlconnection:^(float processUnit, NSString *receivedData) {
        if(processUnit >= 1.0){
            
            NSLog(@"File Content:%@",receivedData);
            
            BOOL isWrite = [[FileManager sharedManager] writeFile:[NSString stringWithFormat:@"%@.json",fileName] fileContent:receivedData];
            if(!isWrite){
                NSLog(@"Failed create file");
            }
            isDownLoadingINprogress = NO;
        }
    } urlString: [NSString stringWithFormat:@"http://tyrogames.com/FootyQuiz/%@.json",fileName]];
}

- (void) play{
    if(isDownLoadingINprogress){
        return;
    }
    
    [menu.view removeFromSuperview];
    [QuestionPage playButtonClicked];
    [self.view addSubview:QuestionPage.view];
}

- (void) goToMainScreen{
    [self.view addSubview:menu.view];
    [QuestionPage.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// for ios 7
- (BOOL)prefersStatusBarHidden{
    return YES;
}

// for ios 6
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // explicitly set the bar to show or it will remain hidden for other view controllers
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

@end
