//
//  UCSDesktopLog.m
//  UCSDesktopLog
//
//  Created by Luzz on 2017/8/14.
//  Copyright © 2017年 UCS. All rights reserved.
//

#import "UCSDesktopLog.h"
#import <objc/runtime.h>

@implementation UCSDesktopLog
+(void)updateLogWithFileName:(NSString *)fileName andLog:(id)log
{
    if ([self actionCondition]) {
        NSString * filePath = [kDesktopLogRootPath() stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
        NSMutableString * content = [[NSMutableString alloc] init];
        [content appendString:@"\n\n"];
        [content appendFormat:@"====== %@ ======\n",currentTime()];
        [content appendString:formatLogContent(log)];
        [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    }
}

+(void)insertLogWithFileName:(NSString *)fileName andLog:(id)log
{
    if ([self actionCondition]) {
        NSString * filePath = [kDesktopLogRootPath() stringByAppendingPathComponent:fileName];
        BOOL isDir;
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir];
        if(isExist && !isDir){
            NSMutableString * oldContent = [[NSMutableString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
            [oldContent appendString:@"\n\n"];
            [oldContent appendFormat:@"====== %@ ======\n",currentTime()];
            [oldContent appendString:formatLogContent(log)];
            [oldContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }else{
            [self updateLogWithFileName:fileName andLog:log];
        }
    }
}

+(void)cleanLog:(NSString *)fileName
{
    if ([self actionCondition]) {
        NSString * filePath = [kDesktopLogRootPath() stringByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
        [@"" writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    }
}

+(BOOL)actionCondition
{
    BOOL flag = NO;
#if (TARGET_IPHONE_SIMULATOR)
    flag = YES;
#else
    #ifdef DEBUG
        flag = YES;
    #else
        flag = NO;
    #endif
#endif
    return flag;
}

NSString * currentTime()
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *timeStr = [formatter stringFromDate:date];
    return timeStr;
}

NSString * formatLogContent(id log)
{
    if(!log){
        return @"UCSNull";
    }
    if([log isKindOfClass:[NSNull class]]){
        return @"UCSNull";
    }
    if([log isKindOfClass:[NSString class]]){
        return log;
    }else if ([log isKindOfClass:[NSArray class]]){
        return [(NSArray *)log componentsJoinedByString:@","];
    }else if ([log isKindOfClass:[NSDictionary class]]){
        return kDicToString(log);
    }else{
        NSDictionary * propertisDic = kProperties_aps(log);
        NSString * modelStr = kDicToString(propertisDic);
        NSString * className = NSStringFromClass([log class]);
        NSMutableString * logStr = [[NSMutableString alloc] initWithFormat:@"%@\n",className];
        [logStr appendString:modelStr];
        return logStr;
        
    }
}

static NSString * kDicToString(NSDictionary * dic)
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = @"";
    if (! jsonData)
    {
        return @"json transfer error";
    }else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonString;
}

static NSDictionary * kProperties_aps(id obj)
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([obj class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [obj valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


static NSString * kDesktopLogRootPath()
{
    NSString * userPath =[[NSHomeDirectory() componentsSeparatedByString:@"Library/Developer"] firstObject];
    NSString * deskTopPath = [userPath stringByAppendingPathComponent:@"Desktop"];
    
    
    NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    appName = appName.length>0?appName:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * fileName = [NSString stringWithFormat:@"桌面日志_%@_%@",appName,version];
    NSString *desktopLogRootPath = [deskTopPath stringByAppendingPathComponent:fileName];
    
    BOOL isDir;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:desktopLogRootPath isDirectory:&isDir];
    if (!isExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:desktopLogRootPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    if (!isDir) {
        [[NSFileManager defaultManager] removeItemAtPath:desktopLogRootPath error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:desktopLogRootPath withIntermediateDirectories:NO attributes:nil error:nil];
    }

    return desktopLogRootPath;
    
}

@end
