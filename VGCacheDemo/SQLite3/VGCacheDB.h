//
//  VGCacheDB.h
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VGCacheModel;

@interface VGCacheDB : NSObject

- (NSArray <VGCacheModel *>*)fetchCacheModelWithLimit:(NSInteger)limit;
- (void)saveModels:(NSArray <VGCacheModel *>*)models;
- (void)updateModel:(VGCacheModel *)model;

@end

NS_ASSUME_NONNULL_END
