//
//  DownloadData.m
//  SampleProject5
//
//  Created by Mobility on 27/05/14.
//  Copyright (c) 2014 Crazyapple. All rights reserved.
//

#import "DownloadData.h"

@implementation DownloadData

@synthesize receivedData;

CompletionBlock blcok;
-(void)downloadWithNsurlconnection
{
    
    
    
}

- (void)downloadWithNsurlconnection:(CompletionBlock)completionBlock urlString:(NSString*) urlString;{
    blcok = completionBlock;
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url         cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    
    
    
    receivedData = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self     startImmediately:YES];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //progress.hidden = NO;
    [receivedData setLength:0];
    expectedBytes = [response expectedContentLength];
    
    NSLog(@"%f",expectedBytes);
    
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
    float progressive = (float)[receivedData length] / (float)expectedBytes;
    //[progress setProgress:progressive];
    
    NSString *downLaodedData = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
   blcok(progressive,downLaodedData);
    
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (NSCachedURLResponse *) connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
   /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfPath = [documentsDirectory stringByAppendingPathComponent:[currentURL stringByAppendingString:@".mp3"]];
   
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [receivedData writeToFile:pdfPath atomically:YES];
    //progress.hidden = YES;*/
    
    //NSString *downLaodedData = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    
     //NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    //NSLog(@"%@",downLaodedData);
    NSString *downLaodedData = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    blcok(1.0,downLaodedData);
}

@end
