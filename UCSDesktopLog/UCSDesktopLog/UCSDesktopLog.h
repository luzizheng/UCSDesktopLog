//
//  UCSDesktopLog.h
//  UCSDesktopLog
//
//  Created by Luzz on 2017/8/14.
//  Copyright © 2017年 UCS. All rights reserved.
//  mac桌面日志

#import <Foundation/Foundation.h>

@interface UCSDesktopLog : NSObject
/**
 *  新建或重写日志 (log : 支持传入任何形式的日志)
 */
+(void)updateLogWithFileName:(NSString *)fileName andLog:(id)log;
/**
 *  插入日志
 */
+(void)insertLogWithFileName:(NSString *)fileName andLog:(id)log;

/**
 *  清空日志
 */
+(void)cleanLog:(NSString *)fileName;
@end
