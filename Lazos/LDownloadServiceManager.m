//
//  STDownloadServiceManager.m
//  Todo2day
//
//  Created by Carlos Alberto Molina Saenz (Vendor) on 11/11/14.
//  Copyright (c) 2014 Sferea. All rights reserved.
//

#import "LDownloadServiceManager.h"
#import <CoreLocation/CoreLocation.h>
#import "LServiceObject.h"


@interface LDownloadServiceManager ()<CLLocationManagerDelegate>

@property(strong, nonatomic) NSMutableData *mutableData;

@end

@implementation LDownloadServiceManager

//- (CLLocationManager *) locationManager
//{
//   
//    
//    return _locationManager;
//}

+ (instancetype)sharedInstance
{
    static LDownloadServiceManager * shared = nil;
    if (!shared)
    {
        shared = [[self alloc] initPrivate];
    }
    return shared;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"This class is a singleton" reason:@"Use +[STDownloadServiceManager sharedInstance]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    return self;
}

- (void)downloadJsonGETWithServiceObject:(LServiceObject *)object
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    
    [[session dataTaskWithURL:object.urlService completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
           NSLog(@"%@ RESPONSE 1: %@",response.URL.absoluteString ,[[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy]);
          //Handle response
          if (!error)
          {
              
              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
              
              if (httpResponse.statusCode == 200)
              {
                  
                  NSError *jsonError;
                  
                  NSString *string = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
                  
                  NSData *utfData = [string dataUsingEncoding:NSUTF8StringEncoding];
                  
                  NSDictionary *comparaJson = [NSJSONSerialization JSONObjectWithData:utfData options:NSJSONReadingAllowFragments error:&jsonError];
                  
                  
                  
                  if (!jsonError)
                  {
                       NSLog(@"%@ RESPONSE 2: %@",response.URL.absoluteString ,string);
                      [object parserJsonReponse:[comparaJson mutableCopy] withError:nil];
                  }
                  else
                  {
                      NSLog(@"jsonError: %@", jsonError);
                      [object parserJsonReponse:nil withError:jsonError];
                      
                      
                  }
                  
              }
              else
              {
                  // EL JSON viene mal formado
                  NSLog(@"EL JSON viene mal formado");
                  NSMutableDictionary* details = [NSMutableDictionary dictionary];
                  [details setValue:@"JSON Problem" forKey:NSLocalizedDescriptionKey];
                  // populate the error object with the details
                  NSError * error = [NSError errorWithDomain:@"JSON PROBLEM" code:404 userInfo:details];
                  [object parserJsonReponse:nil withError:error];
                  
                  
              }
              
          }
          else
          {
              //No se pudo realizar la conexion exitosamente
              NSLog(@"No se pudo realizar la conexion exitosamente para descargar el JSON.");
              [object parserJsonReponse:nil withError:error];
              
              
          }
          
          
          
      }] resume];
    
}


- (void)downloadJsonPOSTWithServiceObject:(LServiceObject *)object
{
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = object.urlService;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];

    NSData *postData = [NSJSONSerialization dataWithJSONObject:object.jsonRequest options:0 error:&error];
    [request setHTTPBody:postData];
    
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        //Handle response
        if (!error)
        {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            //NSString *string = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
            
            if (httpResponse.statusCode == 200)
            {
                
                NSError *jsonError;
                
                NSString *string = [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy];
                
                NSData *utfData = [string dataUsingEncoding:NSUTF8StringEncoding];
                
                NSDictionary *comparaJson = [NSJSONSerialization JSONObjectWithData:utfData options:NSJSONReadingAllowFragments error:&jsonError];
                
                
                
                if (!jsonError)
                {
                    NSLog(@"%@ RESPONSE: %@",response.URL.absoluteString ,string);
                    [object parserJsonReponse:[comparaJson mutableCopy] withError:jsonError];
                }
                else
                {
                    NSLog(@"jsonError: %@", jsonError);
                    [object parserJsonReponse:nil withError:jsonError];
                    
                    
                }
                
            }
            else
            {
                // EL JSON viene mal formado
                NSLog(@"EL JSON viene mal formado");
                NSMutableDictionary* details = [NSMutableDictionary dictionary];
                [details setValue:@"JSON Problem" forKey:NSLocalizedDescriptionKey];
                // populate the error object with the details
                NSError * error = [NSError errorWithDomain:@"JSON PROBLEM" code:404 userInfo:details];
                [object parserJsonReponse:nil withError:error];
                
                
            }
            
        }
        else
        {
            //No se pudo realizar la conexion exitosamente
            NSLog(@"No se pudo realizar la conexion exitosamente para descargar el JSON.");
            [object parserJsonReponse:nil withError:error];
            
            
        }

        
    }];
    
    [postDataTask resume];
}

#pragma -mark Parser

- (void) parserJson:(NSDictionary *) json
{
}

- (void)parserCategories:(NSDictionary *) json
{


}

@end
