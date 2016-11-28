//
//  VGKeyedArchiverStore.m
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import "VGFileManagerCommon.h"
#import "VGKeyedArchiverStore.h"

@implementation VGKeyedArchiverStore

+ (instancetype)store
{
    return [[self alloc] init];
}

- (void)fetchItemsWithCompletion:(VGKeyedArchiverStoreFetchCompletionHandler)completion
{
    if ([VGFileManagerCommon isFileExistAtPath:[self savePath]]) {
        VGCacheModel *model = [self loadModel];
        completion(model);
    }
}

- (VGCacheModel *)loadModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self savePath]];
}

- (NSString *)savePath
{
    NSString *path = @"keyedArchiverStore.bin";
    return [[VGFileManagerCommon getDocumentPath] stringByAppendingPathComponent:path];
}

- (void)saveModel:(VGCacheModel *)Model
{
    BOOL success = [NSKeyedArchiver archiveRootObject:Model toFile:[self savePath]];
    if (!success) {
        NSLog(@"Save Failed");
    }
}

@end
