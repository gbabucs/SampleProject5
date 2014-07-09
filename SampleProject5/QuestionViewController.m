//
//  QuestionViewController.m
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "QuestionViewController.h"
#import "UIButton+CustomButton.h"
#import "QuestionClass.h"
#import  <QuartzCore/QuartzCore.h>
#import "FileManager.h"

NSTimer *timer;
int totalTime;
UILabel *timeLbl;
UIButton *backBtn;
id viewControllerObject;
int totalQuestionCount;
UIButton *nextBtn;

int TotalSec;

@interface QuestionViewController ()

@end

@implementation QuestionViewController



static QuestionViewController *sharedMyManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (id)sharedManager:(id)VewControllerObj {
    
    @synchronized(self) {
        if (sharedMyManager == nil){            
            
            viewControllerObject = VewControllerObj;
            
            sharedMyManager = [[self alloc] init];
            
            
            sharedMyManager->todayQuestion = [[NSMutableArray alloc] init];
            sharedMyManager.view.frame = CGRectMake(0, 0, 768/screenRatioX, 1024/screenRatioY);
            
            
            int gap = 0;
            
            sharedMyManager->correctAnsweraBG = [[UILabel alloc] initWithFrame:CGRectMake(50/screenRatioX, -100, 650/screenRatioX, 100/screenRatioY)];
            sharedMyManager->correctAnsweraBG.backgroundColor = [UIColor greenColor];
            sharedMyManager->correctAnsweraBG.layer.cornerRadius = 5;
            [sharedMyManager.view addSubview:sharedMyManager->correctAnsweraBG];
            
            for(int i = 0; i < 5;i++){
                if(i == 0){
                    sharedMyManager->QuestionLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(50/screenRatioX, 120/screenRatioY, 700/screenRatioX, 200/screenRatioY)];
                    gap = 225;
                    sharedMyManager->QuestionLabel[i].lineBreakMode = YES;
                    sharedMyManager->QuestionLabel[i].numberOfLines = 0;
                    //QuestionLabel[i].backgroundColor = [UIColor greenColor];
                }else{
                    sharedMyManager->QuestionLabel[i] = [[UILabel alloc] initWithFrame:CGRectMake(120/screenRatioX, (345 + ((i -1) * gap))/screenRatioY , 600/screenRatioX, 100/screenRatioY)];
                    //QuestionLabel[i].backgroundColor = [UIColor redColor];
                    
                    gap = 120;
                }
                [sharedMyManager.view addSubview:sharedMyManager->QuestionLabel[i]];
                
            }
            
            sharedMyManager->currentQuestionIndex = 0;
            
            
            for(int i = 0 ; i < 4; i++){
                UIButton *btn = [UIButton buttonItemWithImage:[UIImage imageNamed:@"radioButtonON.png"] target:sharedMyManager action:@selector(checkAnswer:) position:CGRectMake(50/screenRatioX, (370+(i*120))/screenRatioY, 25, 25) tag:i+1];
                [sharedMyManager.view addSubview:btn];
            }
            nextBtn = [UIButton buttonItemWithText:@"Next" textColor:[UIColor redColor] fontSize:28/screenRatioY target:sharedMyManager action:@selector(nextQuestion) position:CGRectMake(650/screenRatioX, (1024-200)/screenRatioY, 100/screenRatioX,100/screenRatioY) tag:100];
            
            [sharedMyManager.view addSubview:nextBtn];
            
            timeLbl = [[UILabel alloc] initWithFrame:CGRectMake(625/screenRatioX, 5/screenRatioY, 90/screenRatioX, 90/screenRatioY)];
            timeLbl.text = [NSString stringWithFormat:@"%d",TotalSec];
            timeLbl.layer.cornerRadius = 25;
            timeLbl.textAlignment = NSTextAlignmentCenter;
            timeLbl.backgroundColor = [UIColor whiteColor];
            [sharedMyManager.view addSubview:timeLbl];
            
            backBtn = [UIButton buttonItemWithText:@"Back" textColor:[UIColor blackColor] fontSize:30/screenRatioY target:viewControllerObject action:@selector(goToMainScreen) position:CGRectMake(50/screenRatioX,25/screenRatioY, 150/screenRatioX,50/screenRatioY) tag:101];
            backBtn.backgroundColor = [UIColor whiteColor];
            backBtn.layer.cornerRadius = 10;
            
            //[sharedMyManager.view addSubview:backBtn];
            
            totalQuestionCount = 2;
            TotalSec = 60;
            
        }
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:sharedMyManager selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
    }
    
    return sharedMyManager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)nextQuestion{
    
    if(totalNumberOFQuestion - 1 == currentQuestionIndex){
        nextBtn.hidden = YES;
    }
    
    if(totalNumberOFQuestion - 1 > currentQuestionIndex){
        currentQuestionIndex++;
        [sharedMyManager updateQuestion:currentQuestionIndex];
    }
    
   
}


- (void) updateQuestion:(int)QuestionIndex{
    totalTime = TotalSec;
    @try {
        QuestionClass *tempQuesObj = [sharedMyManager->todayQuestion objectAtIndex:QuestionIndex];
        
        //NSLog(@"%@",tempQuesObj.Question);
        
        sharedMyManager->QuestionLabel[0].text = tempQuesObj.Question;
        sharedMyManager->QuestionLabel[1].text = tempQuesObj.answerOne;
        sharedMyManager->QuestionLabel[2].text = tempQuesObj.answerTwo;
        sharedMyManager->QuestionLabel[3].text = tempQuesObj.answerThree;
        sharedMyManager->QuestionLabel[4].text = tempQuesObj.answerFour;
        
        CGRect frame = sharedMyManager->correctAnsweraBG.frame;
        frame.origin.y = -100;
        
        [UIView beginAnimations:nil context:NULL]; // animate the following:
        sharedMyManager->correctAnsweraBG.frame = frame; // move to new location
        [UIView setAnimationDuration:0.3];
        [UIView commitAnimations];
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",[exception description]);
    }
}

- (void) playButtonClicked{
    totalTime = TotalSec;
    [sharedMyManager readDataFromXml];
    [sharedMyManager updateQuestion:sharedMyManager->currentQuestionIndex];
    sharedMyManager.bottomBar.hidden = YES;    
}

- (NSMutableArray*)readDataFromXml{
    
    NSString *jsonString = [[FileManager sharedManager] readFile:[NSString stringWithFormat:@"%@.json",fileName]];
    
    //@"{\"questionone\": [\"1. Who won 2011 cricket worldcup\",\"West Indies\",\"India\",\"Australia\",\"England\",\"India\"],\"questiontwo\": [\"2. Who won 2011 football worldcup\",\"West Indies\",\"India\",\"Australia\",\"England\",\"India\"]}";
    
    if(jsonString){
        NSLog(@"json Stirng:%@",jsonString);
        
        NSData* data = [jsonString dataUsingEncoding: NSUTF8StringEncoding];
        
        NSError *error = NULL;
        
        NSDictionary *allQuestion = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error)
            NSLog(@"JSONObjectWithData error: %@", error);
        
        NSArray *allKeys = [allQuestion allKeys];
        
        totalNumberOFQuestion = [allKeys count];
        
        for(NSString *keys in allKeys){
            NSArray *eachQuestion = [allQuestion objectForKey:keys];
            
            QuestionClass *quesObj = [[QuestionClass alloc] init];
            
            quesObj.Question = [eachQuestion objectAtIndex:0];
            quesObj.answerOne = [eachQuestion objectAtIndex:1];
            quesObj.answerTwo = [eachQuestion objectAtIndex:2];
            quesObj.answerThree = [eachQuestion objectAtIndex:3];
            quesObj.answerFour = [eachQuestion objectAtIndex:4];
            quesObj.correctAnswer = [eachQuestion objectAtIndex:5];
            
            [sharedMyManager->todayQuestion addObject:quesObj];
        }     

    }
    
    return sharedMyManager->todayQuestion;
}

- (void) checkAnswer:(id) sender{
    
    if(sharedMyManager->correctAnsweraBG.frame.origin.y > 0){
        return;
    }
    
    UIButton *answerBtn = (UIButton *)sender;
    QuestionClass *tempQuesObj = [sharedMyManager->todayQuestion objectAtIndex:currentQuestionIndex];
    
    NSString *selectedString = [[NSString alloc] init];
    if(answerBtn.tag == 1)
        selectedString = tempQuesObj.answerOne;
    else if(answerBtn.tag == 2)
        selectedString = tempQuesObj.answerTwo;
    else if(answerBtn.tag == 3)
        selectedString = tempQuesObj.answerThree;
    else if(answerBtn.tag == 4)
        selectedString = tempQuesObj.answerFour;
   
    CGRect frame = sharedMyManager->correctAnsweraBG.frame;
    frame.origin.y = (345+((answerBtn.tag-1) *120))/screenRatioY;
    
    [UIView beginAnimations:nil context:NULL]; // animate the following:
    sharedMyManager->correctAnsweraBG.frame = frame; // move to new location
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
    
    if([selectedString isEqualToString:tempQuesObj.correctAnswer]){
        sharedMyManager->correctAnsweraBG.backgroundColor = [UIColor greenColor];
    }else{
        sharedMyManager->correctAnsweraBG.backgroundColor = [UIColor redColor];
    }
}

- (void) updateTimerLabel{
    
    if(totalTime >= 0 && sharedMyManager->correctAnsweraBG.frame.origin.y < 0){
        timeLbl.text = [NSString stringWithFormat:@"%d",totalTime];
        totalTime--;
        if(totalTime == 0){
            [sharedMyManager nextQuestion];
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
