//
//  SSServiceObject.h
//  survey
//
//  Created by Werever on 16/01/15.
//  Copyright (c) 2015 Carlos Alberto Molina Saenz (Vendor). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LDownloadServiceManager.h"

typedef enum
{
    LServicePetitionGET = 0,
    LServicePetitionPOST,
    
    
} SSServicePetition;

typedef void(^SSServiceObjectBlock)(NSDictionary * json, NSError * error);

@interface LServiceObject : NSObject

@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSMutableDictionary * jsonRequest;
@property (nonatomic) SSServicePetition typePetition;
@property (nonatomic) SSServices typeService;
@property (strong, nonatomic) NSURL * urlService;
@property (nonatomic, copy) SSServiceObjectBlock customBlock;
- (void)startDownload;
- (void)parserJsonReponse:(NSMutableDictionary *) json withError:(NSError *) error;

- (NSDate *)dateFromJsonString: (NSString *) dateString;

@end
