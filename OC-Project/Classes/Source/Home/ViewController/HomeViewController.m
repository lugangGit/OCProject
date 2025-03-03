//
//  HomeViewController.m
//  OC-Project
//
//  Created by 卢梓源 on 2020/12/15.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "HomeViewModel.h"
#import "ArticleCell.h"
#import "TracingPCs.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int num;

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
//
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.homeVM.pageModel.current_page = 0;
//        [self loadData];
//    }];
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        self.homeVM.pageModel.current_page ++;
//        [self loadData];
//    }];
    
//    //请求数据
//    [self loadData];
//    //创建UI
//    [self createUI];
    
//    [TracingPCs writeOrderFile];
    [self test4];
    
    static int age = 20;
    NSString *name = @"zhangsan";
    void(^block)(void) = ^{
        NSLog(@"%d", age);
//        NSLog(@"%@", name);
    };
    block();
    NSLog(@"%@", block);

}

- (void)test1 {
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)test2 {
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)test3 {
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    //FIFO
    dispatch_async(queue, ^{
        NSLog(@"2");
        dispatch_async(queue, ^{
            NSLog(@"3");
        });
        sleep(5);
        NSLog(@"4");
    });
    dispatch_async(queue, ^{
        NSLog(@"6");
    });
    NSLog(@"5");
}

- (void)test4 {
    dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t, ^{
        NSLog(@"1");
    });
    dispatch_async(t, ^{
        NSLog(@"2");
    });
    dispatch_sync(t, ^{
        sleep(3);
        NSLog(@"3");
    });
    NSLog(@"0");
    dispatch_async(t, ^{
        NSLog(@"4");
    });
    dispatch_async(t, ^{
        NSLog(@"5");
    });
    dispatch_async(t, ^{
        NSLog(@"6");
    });
}

- (void)test5 {
    dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(t, ^{
        NSLog(@"2");
        dispatch_async(t, ^{
            sleep(5);
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)test6 {
    dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_sync(t, ^{
        NSLog(@"2");
        dispatch_async(t, ^{
            NSLog(@"3");
        });
        sleep(5);
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)test7 {
    dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(t, ^{
        NSLog(@"2");
        dispatch_sync(t, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

- (void)test8 {
    self.num = 0;
    while (self.num < 100) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            self.num++;
        });
    }
    // >=100，否则while循环不能出来，dispatch_async线程不安全。
    NSLog(@"===%d", self.num);
}

- (void)test9 {
    self.num = 0;
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    NSLock *l = [[NSLock alloc] init];
    for (int i = 0; i < 100; i++) {
        dispatch_async(queue, ^{
            self.num++;
        });
    }
    NSLog(@"======%d", self.num);
}

//- (instancetype)shareDate {
//    static id instance;
//    dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc] init];
//    });
//    return  instance;
//}

- (void)test10 {
    dispatch_queue_t t = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t, ^{
        NSLog(@"1");
    });
    dispatch_sync(t, ^{
        sleep(3);
        NSLog(@"2");
    });
    //栅栏函数只能是并发队列，不能是全局并发队列，全局并发队列源码里没有任何相关的栅栏函数操作
    //而dispatch_barrier_sync同步时（dispatch_sync相同）会阻塞线程，4在3后
    dispatch_barrier_async(t, ^{
        sleep(2);
        NSLog(@"3");
    });
    NSLog(@"4");
    dispatch_async(t, ^{
        NSLog(@"5");
    });
    dispatch_async(t, ^{
        NSLog(@"6");
    });
}

- (void)test11 {
    dispatch_queue_t t = dispatch_group_create();

    dispatch_queue_t t1 = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_async(t, t1, ^{
        
    });

}

#pragma mark - 请求数据
- (void)loadData {
    [self.homeVM loadArticlesWithColumnId:17479 lastFileId:0 completionHandler:^(BOOL isSuccess, NSString *message, id obj) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden =  self.homeVM.dataArray.count ? NO : YES;
        if(self.homeVM.pageModel.total == self.homeVM.dataArray.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        if (isSuccess) {
            [self.tableView reloadData];
        }else {
            [self showMessage:message];
        }
    }];
}

#pragma mark - 创建UI
- (void)createUI {
    self.tableView.mj_footer.hidden = YES;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(0);
    }];
}

#pragma mark - tableview 代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeVM.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierId = @"cell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierId];
    if (cell == nil) {
        cell = [[ArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
    }
    ArticleModel *article = [self.homeVM.dataArray objectAtIndex:indexPath.row];
    [cell updateWithModel:article];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LoginViewController *VC = [[LoginViewController alloc] init];
    VC.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:VC animated:YES completion:nil];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kColorWhite;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
