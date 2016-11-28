//
//  ViewController.m
//  VGCacheDemo
//
//  Created by gwr on 2016/11/28.
//  Copyright © 2016年 gwr. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "ViewController.h"
#import "VGCacheModel.h"

#import "VGPlistStore.h"
#import "VGKeyedArchiverStore.h"
#import "VGCacheDB.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *keyedAcrchiverLabel;
@property (weak, nonatomic) IBOutlet UILabel *plistLabel;
@property (weak, nonatomic) IBOutlet UILabel *dbLabel;

@property (strong, nonatomic) VGCacheModel *model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    VGCacheModel *model = [[VGCacheModel alloc]init];
    model.uid = 1;
    model.imageURL = @"https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png";
    model.title = @"apple";
    self.model = model;
    
    [self loadCache:nil];
}


- (IBAction)keyedArchiverStore:(UIButton *)sender {
    [[VGKeyedArchiverStore store]saveModel:self.model];
    NSLog(@"归档");
}

- (IBAction)plistStore:(UIButton *)sender {
    NSDictionary *json = [MTLJSONAdapter JSONDictionaryFromModel:self.model error:nil];
    [[VGPlistStore store]saveJSON:json];
    NSLog(@"plist");
}

- (IBAction)DBStore:(UIButton *)sender {
    VGCacheDB *db = [[VGCacheDB alloc]init];
    [db saveModels:@[self.model]];
    NSLog(@"DB");
}
- (IBAction)loadCache:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [[VGKeyedArchiverStore store]fetchItemsWithCompletion:^(VGCacheModel * _Nonnull model) {
        weakSelf.keyedAcrchiverLabel.text = [NSString stringWithFormat:@"归档： uid: %ld imageURL: %@  title: %@",
                                             (long)model.uid, model.imageURL, model.title];
    }];
    
    [[VGPlistStore store]fetchItemsWithCompletion:^(NSDictionary * _Nullable dict) {
        VGCacheModel *model = [MTLJSONAdapter modelOfClass:[VGCacheModel class] fromJSONDictionary:dict error:nil];
        weakSelf.plistLabel.text = [NSString stringWithFormat:@"PLIST:  uid: %ld imageURL: %@  title: %@",
                                             (long)model.uid, model.imageURL, model.title];
    }];
    
    VGCacheDB *db = [[VGCacheDB alloc]init];
    NSArray <VGCacheModel *>*array = [db fetchCacheModelWithLimit:1];
    VGCacheModel *model = [array firstObject];
    self.dbLabel.text = [NSString stringWithFormat:@"DB：  uid: %ld imageURL: %@  title: %@",
                         (long)model.uid, model.imageURL, model.title];
    
}

@end
