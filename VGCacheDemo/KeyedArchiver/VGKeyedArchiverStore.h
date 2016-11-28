//
//  VGKeyedArchiverStore.h
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

/*
 *  实现NSKeyedArchiver 归档
 *
 *  归档只要遵循了NSCoding协议的对象都可以通过它实现序列化。
 *
 *  遵从NSCoding协议
 *  平时项目中使用Mantle 来实现model层 Mantle已经实现了NSCoding协议
 *
 *  这里是直接存储model  但建议还是把Model转换成JSON Dictionary 来存储
 *  load时再转换成model
 */

#import <Foundation/Foundation.h>
#import "VGCacheModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^VGKeyedArchiverStoreFetchCompletionHandler)(VGCacheModel *);


@interface VGKeyedArchiverStore : NSObject

+ (instancetype)store;

- (void)fetchItemsWithCompletion:(VGKeyedArchiverStoreFetchCompletionHandler)completion;
- (void)saveModel:(VGCacheModel *)Model;

@end

NS_ASSUME_NONNULL_END
