//
//  STDownloadServiceManager.h
//  Todo2day
//
//  Created by Carlos Alberto Molina Saenz (Vendor) on 11/11/14.
//  Copyright (c) 2014 Sferea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LServiceObject;
typedef enum
{
    SSServiceLogin = 0,
    
} SSServices;

@interface LDownloadServiceManager : NSObject
+ (instancetype)sharedInstance;
- (void)downloadJsonPOSTWithServiceObject:(LServiceObject *)object;
- (void)downloadJsonGETWithServiceObject:(LServiceObject *)object;

@end
