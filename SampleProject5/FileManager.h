//
//  FileManager.h
//  SampleProject5
//
//  Created by Mobility on 02/06/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (id)sharedManager;
- (BOOL) writeFile:(NSString*)fileName fileContent:(NSString*)content;
- (NSString*) readFile:(NSString*)fileName;

@end
