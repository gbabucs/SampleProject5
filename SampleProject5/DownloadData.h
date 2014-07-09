//
//  DownloadData.h
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DownloadData : NSURLConnection{
    float         expectedBytes;
}
typedef void (^CompletionBlock)(float processUnit,NSString *receivedData);

@property(strong)NSMutableData *receivedData;

-(void)downloadWithNsurlconnection:(CompletionBlock)completionBlock urlString:(NSString*) urlString;

@end
