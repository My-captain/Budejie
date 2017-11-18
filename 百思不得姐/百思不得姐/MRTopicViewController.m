//
//  MRWordViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/9/25.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRTopicViewController.h"
#import "MRTopic.h"
#import "MRTopicCell.h"
#import "MRCommentViewController.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface MRTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
//当前页码
@property (nonatomic, assign) NSInteger page;
//当加载下一页数据时需要这个参数
@property (nonatomic, copy) NSString *maxtime;
//存储上一次请求数据的参数
@property (nonatomic, strong) NSDictionary *parameters;
@end

@implementation MRTopicViewController

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化表格
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
}

static NSString * const MRTopicCellId = @"topic";
#pragma mark - 初始化表格
- (void)setupTableView{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = MRTitlesViewY + MRTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    //设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRTopicCell class]) bundle:nil] forCellReuseIdentifier:MRTopicCellId];
}

#pragma mark - 添加刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - 加载新的帖子数据
- (void)loadNewTopics{
    //终止上拉
    [self.tableView.mj_footer endRefreshing];
    // 初始化页码
    self.page = 0;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.parameters = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        MRLog(@"%@", responseObject);
        if (self.parameters != params) return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 -> 模型
        self.topics = [MRTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if (self.parameters != params) return;
        [self.tableView.mj_header endRefreshing];
    }];
}

//加载更多帖子数据
- (void)loadMoreTopics{
    //终止下拉
    [self.tableView.mj_header endRefreshing];
    self.page++;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    
    self.parameters = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (self.parameters != params) return;
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 -> 模型
        NSArray *newTopics = [MRTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        // 刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        //设置页码
        self.page = page;
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        if (self.parameters != params) return;
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
/**
 * 总共有几组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 * 第section组有几个cell
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:MRTopicCellId];
    
    //根据取出的数据对cell进行个性化
    cell.topic = self.topics[indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出帖子模型
    MRTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}
// 每个cell被选中之后自动调用此方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MRCommentViewController *cmtController = [[MRCommentViewController alloc] init];
    cmtController.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:cmtController animated:YES];
}

@end















