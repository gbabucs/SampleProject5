//
//  FileManager.m
//  SampleProject5
//
//  Created by Mobility on 02/06/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

static id sharedFileManager = nil;
NSArray *paths;
NSString *documentsDirectory;


NSString *fileContent;

+ (id)sharedManager{
    
    @synchronized(self) {
        if (sharedFileManager == nil){
            sharedFileManager = [[self alloc] init];
            paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
            
        }
    }
    return sharedFileManager;
}

-(BOOL) writeFile:(NSString*)fileName fileContent:(NSString*)content{
    NSError *error;
    BOOL succeed = [content writeToFile:[documentsDirectory stringByAppendingPathComponent:fileName]
                                  atomically:YES encoding:NSUTF8StringEncoding error:&error];
    return succeed;
}

- (NSString*) readFile:(NSString*)fileName{

    
    NSError *error;
    NSString *filepath = [documentsDirectory stringByAppendingPathComponent:fileName];

    fileContent = [[NSString alloc] initWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    return fileContent;
}

@end
