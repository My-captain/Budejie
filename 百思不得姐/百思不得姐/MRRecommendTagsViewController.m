//
//  MRRecommendTagsViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/13.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendTagsViewController.h"
#import "MRRecommendTag.h"
#import "MRRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface MRRecommendTagsViewController ()

@property (nonatomic, strong) NSArray *tags;

@end

static NSString * const MRTagsId = @"tag";

@implementation MRRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadTags];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)loadTags{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        self.tags = [MRRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:MRTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    

    
    return cell;
}

- (void)setupTableView{
    self.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:MRTagsId];
    self.tableView.rowHeight = 86;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = MRGlobalBg;
}

@end






