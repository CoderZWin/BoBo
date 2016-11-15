//
//  WZBaseTabViewController.m
//  mdbobo
//
//  Created by WangZhen on 2016/11/14.
//  Copyright © 2016年 WangZhen. All rights reserved.
//

#import "WZBaseTabViewController.h"

static NSString * const ID = @"Cell";

@interface WZBaseTabViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, weak) UIScrollView *titleView;
@property(nonatomic, weak) UIButton *selectedButton;
@property(nonatomic, weak) UICollectionView *buttonCollectionView;
@property(nonatomic, strong) NSMutableArray *TitleButtons;
@property(nonatomic, weak) UIView *underLine;
@property(nonatomic, assign) BOOL isInitial;

@end

@implementation WZBaseTabViewController


// 懒加载TitleButtons数组
- (NSMutableArray *)TitleButtons {
    
    if (_TitleButtons == nil) {
        _TitleButtons = [NSMutableArray array];
    }
    return _TitleButtons;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加显示内容的CollectionView
    [self setupBottomContaninerView];
    
    // 添加导航条下的标题栏:用ScrollView
    [self setupTopTitleView];
    
    // 添加上面标题view的所有button
    [self setupAllTitleButton];
    
    //取消自动添加额外滚动区域(如果遇到标题TitleButton显示不出来就把这句话写上就可以了)
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    if (_isInitial == NO) {
        //添加所有标题按钮
        [self setupAllTitleButton];
        
        _isInitial = YES;
    }
}


// 添加显示内容标题栏
- (void)setupTopTitleView {
    
    // 标题的Y值由导航条是否显示决定:如果隐藏就是20,如果导航条显示就是64
    CGFloat y = self.navigationController.navigationBarHidden?20:64;
    // ScrollView的好处:当以后要扩展标题时可以向后滚动查看后面
    UIScrollView *topTitleSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y, WZScreenWidth, 35)];
    _titleView = topTitleSV;
    
    topTitleSV.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    [self.view addSubview:topTitleSV];
}


// 添加显示内容的view
- (void)setupBottomContaninerView {
    
    // 先创建流水布局对象(必须先设置流水布局)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置itemCell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    //设置滚动方向 --> Horizontal:水平方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //上下间距
    layout.minimumLineSpacing = 0;
    //左右间距
    layout.minimumInteritemSpacing = 0;
    
    // CollectionView的好处: 滚动分页查看,不会造成离屏渲染
    UICollectionView *bottomCV = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    
    [bottomCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    // 设置数据源
    bottomCV.dataSource = self;
    // 设置代理
    bottomCV.delegate = self;
    _buttonCollectionView = bottomCV;
    
    bottomCV.backgroundColor = [UIColor greenColor];
    //取消垂直显示条
    bottomCV.showsVerticalScrollIndicator = NO;
    //取消水平显示条
    bottomCV.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    bottomCV.bounces = NO;
    //自动分页
    bottomCV.pagingEnabled = YES;
    
    [self.view addSubview:bottomCV];
}



- (void)setupAllTitleButton {
    
    //获取需要创建but的个数
    NSInteger btnCount = self.childViewControllers.count;
    //定义frame
    NSInteger btnX = 0;
    NSInteger btnW = _titleView.fw_width / btnCount;
    NSInteger btnH = _titleView.fw_height;
    
    //遍历设置title
    for (NSInteger i = 0; i < btnCount; i++) {
        
        btnX = i * btnW;
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 给按钮设置一个tag值,用于判断点击的是哪一个title按钮
        titleBtn.tag = i;
        
        UIViewController *VC = self.childViewControllers[i];
        
        [titleBtn setTitle:VC.title forState:UIControlStateNormal];
        
        titleBtn.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_titleView addSubview:titleBtn];
        
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //纯代码创建并设置的选中颜色必须要用代码改变选中状态才会有颜色切换效果
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        //为每个按钮添加按钮点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 把所有TitleButtons添加到数组中去
        [self.TitleButtons addObject:titleBtn];
        
        // 默认选中第0个titleButton
        if (i == 0) {
            
            // 在这里添加按钮的下划线:因为在这里既可以拿到按钮设置下划线的中心点与按钮的中心点对齐,也能保证这个下划线只添加一次
            UIView *underLine = [[UIView alloc] init];
            underLine.backgroundColor = [UIColor redColor];
            [_titleView addSubview:underLine];
            _underLine = underLine;
            
            // 设置尺寸位置,注:titleBtn由于还没加载出来没有确切的尺寸位置,需要sizeToFit
            [titleBtn.titleLabel sizeToFit];
            underLine.fw_width = titleBtn.titleLabel.fw_width;
            underLine.fw_height = 2;
            underLine.fw_center_x = titleBtn.fw_center_x;
            underLine.fw_y = _titleView.fw_height - underLine.fw_height;
            
            // 默认选中第0个titleButton
            [self titleBtnClick:titleBtn];
        }
    }
    
    
}



//监听上面标题的view的每个按钮的点击事件
- (void)titleBtnClick:(UIButton *)button {
    
    [self selButton:button];
    
    // 判断那个按钮被点击就滚到对应cell的位置
    NSInteger i = button.tag;
    CGFloat offsetX = i * WZScreenWidth;
    _buttonCollectionView.contentOffset = CGPointMake(offsetX, 0);
}

#pragma mark - 选中标题
- (void)selButton:(UIButton *)button {
    
    //改变选中状态三部曲
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    // 无论是点击标题按钮滚动视图, 或者是屏幕拖动滚动视图都会来到这个方法, 我们可以在这里设置下划线的移动
    [UIView animateWithDuration:0.25 animations:^{
        _underLine.fw_center_x = button.fw_center_x;
    }];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.childViewControllers.count;
}


//屏幕上每次有cell出现都会来到这个方法
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    //生成一个随机颜色
    //    cell.backgroundColor = WZRandomColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    
    //移除之前的view
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //取出要将要显示的cell
    UITableViewController *Vc = self.childViewControllers[indexPath.row];
    Vc.view.frame = [UIScreen mainScreen].bounds;
    
    Vc.tableView.contentInset = UIEdgeInsetsMake(_titleView.fw_height + 64, 0, 49, 0);
    //添加上去
    [cell.contentView addSubview:Vc.view];
    
    return cell;
}


// 当collectionView滚动完成时就会来到这个方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 先算出当前第几页
    NSInteger page = scrollView.contentOffset.x / WZScreenWidth;
    // 从按钮数组中取出当前页的按钮
    UIButton *titleBtn = self.TitleButtons[page];
    
    // 利用按钮调用选中按钮的方法
    [self selButton:titleBtn];
    
}
@end
