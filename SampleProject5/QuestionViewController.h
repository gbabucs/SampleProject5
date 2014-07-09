//
//  QuestionViewController.h
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "SuperViewController.h"

@interface QuestionViewController : SuperViewController{
    UILabel *QuestionLabel[5];
    NSMutableArray *todayQuestion;
    int currentQuestionIndex;
    
    UILabel *correctAnsweraBG;
}
+ (id)sharedManager:(id)VewControllerObj;
- (void) playButtonClicked;
@end

