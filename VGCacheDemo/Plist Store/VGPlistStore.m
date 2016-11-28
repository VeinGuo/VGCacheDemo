//
//  VGPlistStore.m
//  VGMulti-taskDownload
//
//  Created by Vein on 2016/10/5.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import "VGFileManagerCommon.h"
#import "VGPlistStore.h"

@implementation VGPlistStore

+ (instancetype)store
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)fetchItemsWithCompletion:(VGPlistStoreFetchCompletionHandler)completion{
    NSDictionary *cacheJson = [self loadCache];
    if (completion) {
        completion(cacheJson);
    }
}

- (NSDictionary *)loadCache
{
    NSString *path = [self savePath];
    if ([VGFileManagerCommon isFileExistAtPath:path]) {
        return [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return nil;
}

- (NSString *)savePath
{
    return [[VGFileManagerCommon getDocumentPath] stringByAppendingPathComponent:@"cache.plist"];
}

- (void)saveJSON:(NSDictionary *)json
{
    if (json) {
        NSString *path = [self savePath];
        [json writeToFile:path atomically:YES];
    }
}

@end
