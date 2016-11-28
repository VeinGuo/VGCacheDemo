//
//  VGFileManagerCommon.h
//  VGCacheDemo
//
//  Created by Vein on 2016/11/20.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define FOLDER_FILE_NAME            @"VGFOLDER"
#define LIST_FILE_NAME              @"list.plist"

@interface VGFileManagerCommon : NSObject

/**
 获取文件夹path

 @return path
 */
+ (NSString *)getDocumentPath;

/**
 获取文件大小

 @param fileName 文件名
 @return file size
 */
+ (NSUInteger)getFileSizeAtFileName:(NSString*)fileName;

/**
 检查文件是否存在
 
 @param filePath 文件本地路径
 @return 是否存在
 */
+ (BOOL)isFileExistAtPath:(NSString*)filePath;

/**
 检查文件是否存在

 @param fileName 文件名
 @return 是否存在
 */
+ (BOOL)isFileExistAtFileName:(NSString*)fileName;

/**
 删除文件

 @param fileName 文件名
 @return 返回是否删除成功
 */
+ (BOOL)deleteFileAtFileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
