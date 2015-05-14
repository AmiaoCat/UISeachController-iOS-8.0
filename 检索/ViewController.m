//
//  ViewController.m
//  检索
//
//  Created by Ss on 15/5/14.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import "ViewController.h"
#import "SearchList.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
@property (nonatomic,copy) NSMutableArray *allDataArray;
@property (nonatomic,copy) NSMutableArray *searchResaultDataArray;
@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) UITableViewController *searchTVC;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"搜索控制器";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource  =self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self loadViews];
    
    
}

- (void)loadViews
{
    
    self.searchTVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    _searchTVC.tableView.dataSource = self;
    _searchTVC.tableView.delegate = self;
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:_searchTVC];
   
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;

    
    
    _searchController.searchResultsUpdater =self;
    _searchController.searchBar.placeholder = @"请输入需要查找的内容";

    
    
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarButtonItemAction:)];
    
    
    
    self.navigationItem.leftBarButtonItem = searchBarButtonItem;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        SearchList *a = [[SearchList alloc]initWithName:@"哔哩哔哩" phoneNumber:@"13812345678"gender:@"中性"];
        SearchList *b = [[SearchList alloc]initWithName:@"AcFUN" phoneNumber:@"2338345678"gender:@"啦啦"];
        SearchList *c = [[SearchList alloc]initWithName:@"胡起码黑" phoneNumber:@"888812345678"gender:@"逗比"];
        SearchList *d = [[SearchList alloc]initWithName:@"斗鱼TV" phoneNumber:@"13812345678"gender:@"乌拉"];
        SearchList *e = [[SearchList alloc]initWithName:@"哔哩哔哩" phoneNumber:@"13812345678"gender:@"阿西吧"];
        SearchList *f = [[SearchList alloc]initWithName:@"Google" phoneNumber:@"167845678"gender:@"也熊"];
        SearchList *g = [[SearchList alloc]initWithName:@"虎子" phoneNumber:@"18612345678"gender:@"汉子"];
        
        
        self.allDataArray = [NSMutableArray arrayWithObjects:a,b,c,d,e,f,g ,nil];
        
        //主线程更新页面
        __weak ViewController *weakself = self;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakself.tableView reloadData];
        });
        
    });
}

- (void)searchBarButtonItemAction:(UIBarButtonItem*)sender
{
    self.searchTVC = [[UITableViewController alloc]initWithStyle:UITableViewStylePlain];
    _searchTVC.tableView.dataSource = self;
    _searchTVC.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:_searchTVC];
    
    _searchController.searchResultsUpdater =self;
    _searchController.searchBar.placeholder = @"请输入需要查找的内容";
    //
    [self presentViewController:_searchController animated:YES completion:nil];
    
}

#pragma  TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return (tableView==self.tableView ? _allDataArray.count : _searchResaultDataArray.count);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    // 4. 设置cell要显示的信息
    SearchList *search = (tableView == self.tableView ? _allDataArray[indexPath.row] : _searchResaultDataArray[indexPath.row]);
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    cell.imageView.image = [UIImage imageNamed:@"3"];
    cell.textLabel.text = search.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  %@",search.phoneNumber,search.gender];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}



#pragma mark
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchList *list = (tableView==self.tableView ? _allDataArray[indexPath.row] : _searchResaultDataArray[indexPath.row]);
    UIViewController *vc = [[UIViewController alloc]init];
    vc.title  = list.name;
    vc.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:vc animated:YES];
    
//    // 弹出AlertView显示
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"谁点了这个混蛋！" message:[NSString stringWithFormat:@"姓名：%@ \n电话：%@ \n性别：%@", list.name, list.phoneNumber, list.gender] preferredStyle:UIAlertControllerStyleAlert];
//    
//    // 添加关闭按钮
//    
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        
//    }];
//    [alertController addAction:cancelAction];

    if (_searchResaultDataArray) {
        [_searchController dismissViewControllerAnimated:YES completion:nil];
    }
    
    
     
    
    
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *top = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"------------置顶-------------");
        [tableView setEditing:NO];
    }];
    top.backgroundColor = [UIColor darkGrayColor];
    UITableViewRowAction *mark = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"标记" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"------------标记-------------");
        [tableView setEditing:NO];
    }];
    mark.backgroundColor = [UIColor purpleColor];
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"------------删除-------------");
        [tableView setEditing:NO];
    }];
    delete.backgroundColor = [UIColor cyanColor];
    
    return @[top,mark,delete];
    
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //获得输入的值
    NSString *str = searchController.searchBar.text;
    //创建谓词
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.phoneNumber CONTAINS [CD] %@ OR self.name CONTAINS [CD] %@ OR self.gender CONTAINS [CD] %@",str,str,str];
    
    
    self.searchResaultDataArray = [NSMutableArray arrayWithArray:[_allDataArray filteredArrayUsingPredicate:pre]];
    
    [_searchTVC.tableView reloadData];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
