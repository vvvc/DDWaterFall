//
//  ViewController.m
//  瀑布流
//
//  Created by ZLWL on 2018/6/5.
//  Copyright © 2018年 iOSteam. All rights reserved.
//
#define K_Screen_Width [UIScreen mainScreen].bounds.size.width

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DDWaterFallLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) NSDictionary *dataDict;
@property (nonatomic, weak) UICollectionView *myCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //1.初始化数据
    [self loadMyInfoDataRequest];
    //2.创建collectionview
    DDWaterFallLayout *layout = [[DDWaterFallLayout alloc] init];
    layout.delegate = self;
    layout.sectionInset = UIEdgeInsetsMake(15, 16, 16, 15);
    layout.columnMargin = 10;
    layout.rowMargin = 10;
    layout.columnsCount = 2;
    
    CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.frame.size.height - 20);
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor orangeColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MyCell class] forCellWithReuseIdentifier:@"cellId"];
    [collectionView registerNib:[UINib nibWithNibName:@"MyCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellId"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
    
    [self.view addSubview:collectionView];
    self.myCollectionView = collectionView;
    
    self.myCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshShops)];
}


//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
//    cell.shop = self.shops[indexPath.item];
    cell.shop = self.shops[indexPath.row];
    return cell;
}


- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadMyInfoDataRequest];
    });
}

- (void)refreshShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadMyInfoDataRequest];
    });
}

#pragma mark WaterFallLayoutDelegate
- (CGFloat)waterFallLayout:(DDWaterFallLayout *)waterFallLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    MyWaterfall *shop = self.shops[indexPath.item];
    return shop.h / shop.w * width;
}

/**  collectionView  headerView */
- (CGSize)waterflowLayout:(DDWaterFallLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(K_Screen_Width, 60);
}

/**  collectionView  footerView */
- (CGSize)waterflowLayout:(DDWaterFallLayout *)waterflowLayout sectionFooterAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(K_Screen_Width, 40);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

static NSString * const HeaderID = @"HeaderID";
static NSString * const FooterID = @"FooterID";
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID forIndexPath:indexPath];
        header.backgroundColor = [UIColor redColor];
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterID forIndexPath:indexPath];
        footer.backgroundColor = [UIColor blueColor];
        footer.frame = CGRectMake(0, 0, self.view.bounds.size.width, 0.5);
        return footer;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"-------%ld-------%ld", indexPath.section, indexPath.item);
}

//********************
- (NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void) loadMyInfoDataRequest {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *str = [NSString stringWithFormat:@"http://139.196.101.133:8089/index.php/CApi/Index/personal_center/cuser_id/2"];
        [AFNetworkTool getNetworkDataSuccess:^(NSDictionary *response) {
            NSData * data = (NSData *)response;
            NSDictionary * dictttt = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            self.dataDict = [NSDictionary dictionaryWithDictionary:dictttt[@"data"]];
            [self.shops removeAllObjects];
            NSArray * arr = dictttt[@"data"][@"photos"];
            for (NSDictionary * dict in arr) {
                MyWaterfall * model = [MyWaterfall new];
                model.img = dict[@"img"];
                model.price = dict[@"content"];
                CGSize size = [UIImage getImageSizeWithURL:[NSURL URLWithString:dict[@"img"]]];
                NSLog(@"%0.f----%0.f", size.height,size.width);
                model.w = size.width;
                model.h = size.height;
                [self.shops addObject:model];
            }
            NSLog(@"%@",self.shops);
            [self.myCollectionView reloadData];
            [self.myCollectionView.mj_header endRefreshing];
        } failure:^(NSError *error) {
        } withUrl:str];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myCollectionView reloadData];
        });
    });
}


@end
