/**
 *
 * ......................我佛慈悲.......................
 *                       _oo0oo_
 *                      o8888888o
 *                      88" . "88
 *                      (| -_- |)
 *                      0\  =  /0
 *                    ___/`---'\___
 *                  .' \\|     |// '.
 *                 / \\|||  :  |||// \
 *                / _||||| -卍-|||||- \
 *               |   | \\\  -  /// |   |
 *               | \_|  ''\---/''  |_/ |
 *               \  .-\__  '-'  ___/-. /
 *             ___'. .'  /--.--\  `. .'___
 *          ."" '<  `.___\_<|>_/___.' >' "".
 *         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *         \  \ `_.   \_ __\ /__ _/   .-` /  /
 *     =====`-.____`.___ \_____/___.-`___.-'=====
 *                       `=---='
 *
 *..................佛祖开光 ,永无BUG....................
 *         CSDN博客:http://blog.csdn.net/song5347
 *       github地址:https://github.com/lingsuiderongyan
 *             邮箱:lingsuiderongyan@163.com
 */

#import "LSWanderingController.h"
#import "LSBottomContentViewController.h"
#import "LSBannerViewController.h"

@interface LSWanderingController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;

@property (nonatomic, strong) UIView * headerView;


@end

@implementation LSWanderingController

- (void)viewDidLoad {
    [super viewDidLoad];

    /**
     *  初始化scrollview
     */
    [self setupScrollView];
    
    /**
     *  初始化头部视图
     */
    [self setupHeaderView];
    
    /**
     *  初始化底部视图
     */
    [self setupBottomView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wakeupScrollView) name:@"note" object:nil];

}

#pragma mark - 初始化底部视图
- (void)setupBottomView
{
    LSBottomContentViewController * bottomVc = [[LSBottomContentViewController alloc] init];
    bottomVc.view.frame = CGRectMake(0, navBarH + self.headerView.height , screenW, screenH - navBarH - self.headerView.height);
    [self.scrollView addSubview: bottomVc.view];
    [self addChildViewController:bottomVc];
}

#pragma mark - 初始化图片轮播视图
- (void)setupBanner
{

    LSBannerViewController * bannerVC = [[LSBannerViewController alloc] init];
    bannerVC.view.frame = CGRectMake(0, 0, screenW, LSBannerH);
    [self.headerView addSubview:bannerVC.view];
    [self addChildViewController:bannerVC];
}

- (void)setupAD
{
    CGFloat adViewH = LSHeaderViewH - LSBannerH;
    
    UIScrollView * adView = [[UIScrollView alloc] init];
    adView.frame = CGRectMake(0, LSBannerH, screenW, adViewH);
    [self.headerView addSubview:adView];
    
    CGFloat buttonH = adViewH - LSCommonMargin;
    CGFloat buttonW = buttonH;
    for (int i = 0; i < 9; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(LSCommonMargin * 0.5 + i * adViewH, LSCommonMargin * 0.5, buttonW, buttonH);
        button.backgroundColor = randomColor;
        [adView addSubview:button];
    }
    
    adView.contentSize = CGSizeMake(adViewH * 9, 0);
}

#pragma mark - 初始化头部视图
- (void)setupHeaderView
{
    UIView * headerView = [[UIView alloc] init];
    [self.scrollView addSubview:headerView];
    headerView.frame = CGRectMake(0, navBarH, screenW, LSHeaderViewH);
    headerView.backgroundColor = [UIColor blueColor];
    self.headerView = headerView;
    
    // 初始化图片轮播视图
    [self setupBanner];
    
    // 初始化广告视图
    [self setupAD];
}

#pragma mark - 初始化ScrollView
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(0, screenH * 2);
    
//    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:@"test"];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= 300) {
        scrollView.contentOffset = CGPointMake(0, 300);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UITableViewScrollEnabledChangedNotification" object:nil];
        scrollView.scrollEnabled = NO;
    } else if (scrollView.contentOffset.y >= 0)
    {
        
    }
}

#pragma mark - note
- (void)wakeupScrollView
{
    self.scrollView.scrollEnabled = YES;
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"context:nil];
}

@end
