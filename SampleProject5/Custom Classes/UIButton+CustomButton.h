//
//  UIButton+CustomButton.h
//  samplePro1
//
//  Created by bala on 5/17/13.
//  Copyright (c) 2013 bala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CustomButton){
    
}

+ (UIButton*)buttonItemWithImage:(UIImage*)image target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex;

+ (UIButton*)buttonItemWithText:(NSString*)text backGroundImage:(UIImage *)image target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex;

+ (UIButton*)buttonItemWithText:(NSString*)text textColor:(UIColor*)color fontSize:(float)fontSize target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex;

+ (UIButton*)buttonItemWithText:(NSString*)text textColor:(UIColor*)color fontSize:(float)size target:(id)target action:(SEL)action position:(CGRect )pos tag:(int)tagIndex fontName:(NSString*)fontName;

- (void) setTitle:(NSString *)title;

- (void) setTitleColor:(UIColor *)color;

- (void) setBackgroundClr:(UIColor*)color;

@end
