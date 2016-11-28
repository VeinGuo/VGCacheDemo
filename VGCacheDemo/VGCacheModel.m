//
//  VGCacheModel.m
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import "VGCacheModel.h"

@implementation VGCacheModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"uid",
             @"imageURL" : @"image_url",
             @"title" : @"title"
             };
}

@end
