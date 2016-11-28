//
//  VGFileManagerCommon.m
//  VGMulti-taskDownload
//
//  Created by Vein on 2016/11/20.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import "VGFileManagerCommon.h"

@implementation VGFileManagerCommon

+ (NSString *)getDocumentPath
{
    static NSString *documentPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentPath = [[NSString alloc]initWithFormat:@"%@/%@/",[paths objectAtIndex:0],FOLDER_FILE_NAME];
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentPath])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentPath
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
    });
    
    return documentPath;
}

+ (NSUInteger)getFileSizeAtFileName:(NSString*)fileName{
    NSString *path = [[VGFileManagerCommon getDocumentPath] stringByAppendingPathComponent:fileName];
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil]fileSize];
}

+ (BOOL)isFileExistAtPath:(NSString*)filePath
{
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    return isExist;
}

+ (BOOL)isFileExistAtFileName:(NSString*)fileName
{
    NSString *path = [[VGFileManagerCommon getDocumentPath] stringByAppendingPathComponent:fileName];
    return [VGFileManagerCommon isFileExistAtPath:path];
}

+ (BOOL)deleteFileAtFileName:(NSString *)fileName
{
    NSFileManager   *fileMgr = [NSFileManager defaultManager];
    NSString *deletePath = [[VGFileManagerCommon getDocumentPath] stringByAppendingPathComponent:fileName];
    NSError *err = nil;
    [fileMgr removeItemAtPath:deletePath error:&err];
    return err != nil;
}

@end
