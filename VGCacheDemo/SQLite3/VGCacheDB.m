//
//  VGCacheDB.m
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import <FMDB/FMDB.h>
#import "VGFileManagerCommon.h"
#import "VGCacheModel.h"
#import "VGCacheDB.h"

static const void * const kDatabaseQueueSpecificKey = &kDatabaseQueueSpecificKey;
static const char *databaseQueue = "com.demo.databasequeue";


@interface VGCacheDB ()

@property (strong, nonatomic) FMDatabase *db;

@end

@implementation VGCacheDB

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self openDatabase];
    }
    return self;
}

- (void)openDatabase
{
    NSString *filepath = [[VGFileManagerCommon getDocumentPath] stringByAppendingString:@"cache.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:filepath];
    if ([db open])
    {
        self.db = db;
        NSString *sql = @"CREATE TABLE IF NOT EXISTS CACHE \
        (uid INTEGER PRIMARY KEY, \
        url TEXT, \
        title TEXT)";
        if (![self.db executeUpdate:sql])
        {
            NSLog(@"execute sql %@ error %@",sql,self.db.lastError);
        }

    }
    else
    {
        NSLog(@"open database failed %@",filepath);
    }
}

#pragma mark - public
- (NSArray <VGCacheModel *>*)fetchCacheModelWithLimit:(NSInteger)limit{
    __block NSArray *result = nil;
    NSString *sql = nil;
    if (limit) {
        sql = @"SELECT *FROM CACHE ORDER BY uid DESC LIMIT ?";
    }
    db_sync_safe(^{
        NSMutableArray <VGCacheModel *>*array = [NSMutableArray array];
        FMResultSet *rs = [self.db executeQuery:sql, @(limit)];
        while ([rs next]) {
            VGCacheModel *model = loadToDatabase(rs);
            [array addObject:model];
        }
        [rs close];
        result = array;
    });
    return result;
}


- (void)saveModels:(NSArray <VGCacheModel *>*)models{
    db_sync_safe(^{
        if ([models count]) {
            [self.db beginTransaction];
            for (VGCacheModel*model in models) {
                saveToDatabase(self.db, model);
            }
            [self.db commit];
        }
    });
}

- (void)updateModel:(VGCacheModel *)model{
    NSString *sql = @"UPDATE CACHE SET TITLE = ? WHRER uid = ?";
    db_async(^{
        if (![self.db executeUpdate:sql, model.title, model.uid]) {
            NSLog(@"update failed sql %@",sql);
        }
    });
}

#pragma mark - save & load
static inline VGCacheModel * loadToDatabase(FMResultSet *resultSet)
{
    NSInteger uid = [resultSet longLongIntForColumn:@"uid"];
    NSString *URL = [resultSet stringForColumn:@"url"];
    NSString *title = [resultSet stringForColumn:@"title"];
    
    VGCacheModel *model = [[VGCacheModel alloc] init];
    model.uid = uid;
    model.imageURL = URL;
    model.title = title;
    
    return model;
}

static inline void saveToDatabase(FMDatabase *db, VGCacheModel *model)
{
    NSString *sql = @"INSERT OR REPLACE INTO CACHE(uid, url, title) VALUES(?,?,?)";
    if(![db executeUpdate:sql,
        @(model.uid),
        model.imageURL,
        model.title]){
        NSLog(@"update failed sql %@",sql);
    }
}


#pragma mark - Queue
dispatch_queue_t cacheDatabaseQueue()
{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create(databaseQueue, 0);
        dispatch_queue_set_specific(queue, kDatabaseQueueSpecificKey, (void *)kDatabaseQueueSpecificKey, NULL);
    });
    return queue;
}

typedef void(^dispatch_block)(void);
void db_sync_safe(dispatch_block block)
{
    if (dispatch_get_specific(kDatabaseQueueSpecificKey))
    {
        block();
    }
    else
    {
        dispatch_sync(cacheDatabaseQueue(), ^() {
            block();
        });
    }
}

void db_async(dispatch_block block){
    dispatch_async(cacheDatabaseQueue(), ^() {
        block();
    });
}

@end
