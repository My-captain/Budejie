//
//  MRRecommendViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/8/30.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "MRRecommendCategoryCell.h"
#import <MJExtension.h>
#import "MRRecommendCategory.h"
#import "MRRecommendUserCell.h"
#import "MRRecommendUser.h"
#import <MJRefresh.h>

#define MRSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface MRRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

//左边的类别
@property (nonatomic, strong) NSArray *categories;
//右边推荐关注的用户
//@property (nonatomic, strong) NSArray *recommendUsers;
/* 左侧类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/* 右侧用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/* 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;
/* AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation MRRecommendViewController

static NSString * const MRCategoryId = @"category";
static NSString * const MRUserId = @"user";

- (AFHTTPSessionManager *) manager{
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //控件初始化
    [self setupTableView];
    //添加刷新控件
    [self setupRefresh];
    
    [self loadCategories];
}

- (void)loadCategories {
    // 显示指示器
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];
        
        // 服务器返回的JSON数据
        self.categories = [MRRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.categoryTableView reloadData];
        
        // 默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
    }];
}

- (void)setupTableView{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:MRCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:MRUserId];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 76;
    
    self.title = @"推荐关注";
    
    self.view.backgroundColor = MRGlobalBg;
}

- (void)setupRefresh{
    self.userTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRecommendUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRecommendUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadNewRecommendUsers {
    MRRecommendCategory *recommendCategory = MRSelectedCategory;
    
    recommendCategory.currentPage = 1;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(recommendCategory.ID);
    params[@"page"] = @(recommendCategory.currentPage);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (self.params != params) return;
        
        NSArray *users = [MRRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [recommendCategory.recommendUsers removeAllObjects];
        
        [recommendCategory.recommendUsers addObjectsFromArray:users];
        
        recommendCategory.total = [responseObject[@"total"] integerValue];
        
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
        [self checkmj_FooterState];
    }failure:^(NSURLSessionTask *task, NSError *error) {
        if (self.params != params) return;
        
        //刷新失败
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        [self.userTableView.mj_header endRefreshing];
    }];

}

- (void)loadMoreRecommendUsers{
    MRRecommendCategory *recommendCategory = MRSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @([MRSelectedCategory ID]);
    params[@"page"] = @(++recommendCategory.currentPage);
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject){
        
        NSArray *recommendUsers = [MRRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [recommendCategory.recommendUsers addObjectsFromArray:recommendUsers];
        
        if (self.params != params) return;
        
        [self.userTableView reloadData];
        
        [self checkmj_FooterState];
    } failure:^(NSURLSessionTask *task, NSError *error){
        if (self.params != params) return;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻检测底部控件状态
 */
- (void)checkmj_FooterState {
    MRRecommendCategory *recommendCategory = MRSelectedCategory;
    
    self.userTableView.mj_footer.hidden = (recommendCategory.recommendUsers.count == 0);
    
    if (recommendCategory.recommendUsers.count == recommendCategory.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDateSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.categoryTableView)return self.categories.count;
    
    [self checkmj_FooterState];
    return [MRSelectedCategory recommendUsers].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //左侧类别
    if (tableView == self.categoryTableView) {
        MRRecommendCategoryCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:MRCategoryId];
        
        tableViewCell.category = self.categories[indexPath.row];
        
        return tableViewCell;
    } else{
        //右侧推荐关注的用户表格
        MRRecommendUserCell *userCell = [tableView dequeueReusableCellWithIdentifier:MRUserId];
        userCell.recommendUser = [MRSelectedCategory recommendUsers][indexPath.row];
        return userCell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    MRRecommendCategory *recommendCategory = self.categories[indexPath.row];
    
    if (recommendCategory.recommendUsers.count) {
        
        [self.userTableView reloadData];
        
    } else {
        
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark - 控制器的销毁
- (void)dealloc{
    [self.manager.operationQueue cancelAllOperations];
}

@end







