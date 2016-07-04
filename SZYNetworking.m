//
//  SZYNetworking.m
//  SZYNetworking
//
//  Created by Suzhenyu on 16/2/22.
//
//

#import "SZYNetworking.h"

@implementation SZYNetworking

/** 对NSURLSession的封装 get */
+ (void)get:(NSString *)path params:(NSDictionary *)params finishBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block {
    
    // dictionary -> string
    NSString *str_params = [self parseParams:params];
    // 拼接url，并转码
    NSString *str_url = [[NSString stringWithFormat:@"%@?%@",path,str_params] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:str_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:10.0f];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:block];
    [task resume];
    
}

/** post请求 */
+ (void)post:(NSString *)path params:(NSDictionary *)params finishBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error))block {
    
    NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [parseParamsResult dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"post"];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:block];
    [task resume];
}

//把NSDictionary解析成post格式的NSString字符串
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
    }
    return result;
}

@end
