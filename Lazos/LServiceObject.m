//
//  SSServiceObject.m
//  survey
//
//  Created by Werever on 16/01/15.
//  Copyright (c) 2015 Carlos Alberto Molina Saenz (Vendor). All rights reserved.
//

#import "LServiceObject.h"


@implementation LServiceObject

- (NSURL *)urlService
{
    if (!_urlService)
    {
        _urlService = [[NSURL alloc] init];
    }
    return _urlService;
}

- (NSString *)url
{
    if (!_url)
    {
        _url = [[NSString alloc] init];
    }
    return _url;
}

- (void)startDownload
{
    if (self.typePetition == LServicePetitionPOST)
    {
        [[LDownloadServiceManager sharedInstance] downloadJsonPOSTWithServiceObject:self];
    }
    else
    {
        [[LDownloadServiceManager sharedInstance] downloadJsonGETWithServiceObject:self];
    }
}

- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error
{
    if (error)
    {
        self.customBlock(nil, error);
    }
    else
    {
        NSLog(@"super");
    }
}

- (NSDate *) dateFromJsonString: (NSString *) dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * date = [dateFormatter dateFromString:dateString];
    return date;
    
}

@end
