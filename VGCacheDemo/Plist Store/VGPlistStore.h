//
//  VGPlistStore.h
//  VGCacheDemo
//
//  Created by Vein on 2016/10/5.
//  Copyright © 2016年 gwr. All rights reserved.
//

/*
 *  实现plist持久化存储数据
 *
 *  plist实质是XML文件，plist可以序列化的类型只有以下几种：
 *
 *  NSArray, NSMutableArray
 *  NSDictionary, NSMutableDictionary
 *  NSData, NSMutableData
 *  NSString, NSMutableString
 *  NSNumber
 *  NSDate
 *  此类只实现存储NSDictionary
 *  *** 建议使用json 存储 取出后转成模型，避免增减字段的问题
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^VGPlistStoreFetchCompletionHandler)(NSDictionary * _Nullable dict);

@interface VGPlistStore : NSObject

+ (instancetype)store;
- (void)fetchItemsWithCompletion:(VGPlistStoreFetchCompletionHandler)completion;
- (void)saveJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
