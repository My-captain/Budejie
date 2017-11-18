//
//  MRCommentViewController.m
//  百思不得姐
//
//  Created by Mr.Robot on 2017/10/7.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import "MRCommentViewController.h"
#import "MRTopicCell.h"
#import "MRTopic.h"
#import "MRComment.h"
#import "MRCommentCell.h"
#import "MRCommentHeaderView.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>

static NSString * const MRCommentId = @"comment";

@interface MRCommentViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
// 最热评论
@property (nonatomic, strong) NSArray *hotComments;
// 最新评论
@property (nonatomic, strong) NSMutableArray *latestComments;
@property (nonatomic, strong) MRComment *saved_top_cmt;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) UIMenuController *menuController;
@end

@implementation MRCommentViewController

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (UIMenuController *)menuController {
    if (!_menuController) {
        _menuController = [[UIMenuController alloc] init];
    }
    return _menuController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBasic];
    [self setupHeader];
    [self setupRefresh];
}

- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadMoreComments{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 页码
    NSInteger page = self.page + 1;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    MRComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *newComments = [MRComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 最新评论
        [self.latestComments addObjectsFromArray:newComments];
        
        self.page = page;
        
        [self.tableView reloadData];
//        [self.tableView.mj_footer endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if ((self.latestComments.count + self.hotComments.count) >= total) {
            self.tableView.mj_footer.hidden = YES;
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewComments{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComments = [MRComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        self.latestComments = [MRComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSArray *)commentsInSection:(NSInteger)section{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }
    return self.latestComments;
}

- (MRComment *)commentInIndexPath:(NSIndexPath *)indexPath{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

- (void)setupHeader{
    // 创建header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = MRGlobalBg;
    // 添加cell
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    MRTopicCell *cell = [MRTopicCell cell];
    cell.topic = self.topic;
    cell.size = CGSizeMake(MRScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    // header的高度
    header.height = self.topic.cellHeight + MRTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
}

- (void)setupBasic{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightedImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.backgroundColor = MRGlobalBg;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MRCommentCell class]) bundle:nil] forCellReuseIdentifier:MRCommentId];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, MRTopicCellMargin, 0);
}

- (void)keyboardWillChangeFrame:(NSNotification *)note{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpace.constant = MRScreenH - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    [self.manager invalidateSessionCancelingTasks:YES];
}
#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.hotComments.count)return 2;
    if (self.latestComments.count)return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestComments.count;
    
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MRCommentHeaderView *header = [MRCommentHeaderView headerViewWithTableView:tableView];

    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    MRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:MRCommentId];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MRCommentCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell becomeFirstResponder];
    
//    UIMenuController *menuController = [[UIMenuController alloc] init];
    UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
    UIMenuItem *reply = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(reply:)];
    UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
    self.menuController.menuItems = @[ding, reply, report];
    [self.menuController setTargetRect:cell.bounds inView:cell];
    [self.menuController setMenuVisible:YES animated:NO];
}

- (void)ding:(MRCommentCell *)commentCell{
    
}

- (void)reply:(MRCommentCell *)commentCell{
    
}

- (void)report:(MRCommentCell *)commentCell{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
