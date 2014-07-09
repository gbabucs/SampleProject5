//
//  UIButton+CustomButton.m
//  samplePro1
//
//  Created by bala on 5/17/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)
;
UILabel *Label;

+ (UIButton*)buttonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tagIndex;
    button.backgroundColor = [UIColor clearColor];
    [button setFrame:CGRectMake(pos.origin.x, pos.origin.y, pos.size.width, pos.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (UIButton*)buttonItemWithText:(NSString*)text backGroundImage:(UIImage *)image target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tagIndex;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(pos.origin.x, pos.origin.y, pos.size.width, pos.size.height)];
    [button setImage:image forState:UIControlStateNormal];
    
    
    Label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, pos.size.width, pos.size.height)];
    [Label setText:text];
    Label.textAlignment = NSTextAlignmentCenter;
    
    Label.backgroundColor=[UIColor clearColor];
    //[Label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    Label.textColor=[UIColor whiteColor];
    [button addSubview:Label];   
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (UIButton*)buttonItemWithText:(NSString*)text textColor:(UIColor*)color fontSize:(float)size target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tagIndex;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(pos.origin.x, pos.origin.y, pos.size.width, pos.size.height)];
       
    
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    
    button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = YES;
    button.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:size];
    button.titleLabel.textColor = color;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}
+ (UIButton*)buttonItemWithText:(NSString*)text textColor:(UIColor*)color fontSize:(float)size target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex fontName:(NSString*)fontName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tagIndex;
    [button setBackgroundColor:[UIColor clearColor]];
    [button setFrame:CGRectMake(pos.origin.x, pos.origin.y, pos.size.width, pos.size.height)];
    
    
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
    [button.titleLabel setTextAlignment:UITextAlignmentLeft];
   // button.titleLabel.textAlignment = NSTextAlignmentLeft;
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = YES;
    button.titleLabel.font = [UIFont fontWithName:fontName size:size];
    button.titleLabel.textColor = color;
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
    
}

- (void) setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void) setTitleColor:(UIColor *)color{
    [self setTitleColor:color forState:UIControlStateNormal];
}

- (void) setBackgroundClr:(UIColor*)color{
   [self setBackgroundColor:color];
}

@end
