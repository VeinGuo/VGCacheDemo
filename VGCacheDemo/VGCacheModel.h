//
//  VGCacheModel.h
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface VGCacheModel : MTLModel <MTLJSONSerializing>

@property (assign, nonatomic) NSInteger uid;
@property (copy, nonatomic) NSString *imageURL;
@property (copy, nonatomic) NSString *title;

@end
