//
//  SZYNetworking.h
//  SZYNetworking
//
//  Created by Suzhenyu on 16/2/22.
//
//

#import <Foundation/Foundation.h>

@interface SZYNetworking : NSObject

/** 对NSURLSession的封装 get */
+ (void)get:(NSString *)path params:(NSDictionary *)params finishBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block;

/** 对NSURLSession的封装 post */
+ (void)post:(NSString *)path params:(NSDictionary *)params finishBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block;

@end
