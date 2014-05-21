//
//  MyCostListViewController.m
//  ScreenShow
//
//  Created by 李正峰 on 14-4-8.
//  Copyright (c) 2014年 lee. All rights reserved.
//

#import "MyCostListViewController.h"
#import "CostListViewController.h"
#import "RechangViewController.h"
@interface MyCostListViewController ()

@end

@implementation MyCostListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)loadView
{
    [super loadView];
    
    /*
     m_segment = [[STSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
     @"",
     @"",
     nil]];
     
     [m_segment addTarget:self action:@selector(touchDownAtSegmentIndex) forControlEvents:UIControlEventValueChanged];
     //    m_segment.selectedTextColor = TEXTCOLOR_Red;
     m_segment.normalImageLeft = [UIImage imageNamed:@"待付款订单未选中.png"];
     m_segment.normalImageRight = [UIImage imageNamed:@"全部订单未选中.png"] ;
     m_segment.selectedImageLeft = [UIImage imageNamed:@"待付款订单选中.png"];
     m_segment.selectedImageRight = [UIImage imageNamed:@"全部订单选中.png"];
     
     m_segment.normalTextColor = [UIColor colorWithHex:@"#838383"];
     m_segment.selectedTextColor = [UIColor whiteColor];
     m_segment.selectedTextShadowColor = [UIColor colorWithHex:@"#560b0b"];
     
     m_segment.frame = CGRectMake(10, 10, 300, 0);
     m_segment.hidden = YES;
     
     [self.view addSubview:m_segment];
     */
//    add liu 20140514
//    _segment = [[PBFlatSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, 320, 29)];
//    [_segment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:_segment];
//    [_segment removeAllSegments];
//    for (UIViewController *vc in _viewControllers) {
//        static int i=-1;
//        i++;
//        [_segment insertSegmentWithTitle:vc.title atIndex:i animated:YES];
//    }
//    
//    _segment.selectedSegmentIndex = 0;
    _segment = [[STSegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"充值记录",@"消费记录", nil]];
    [_segment addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    _segment.selectedTextColor = [UIColor whiteColor];
    _segment.normalTextColor = [UIColor blackColor];
    _segment.selectedTextShadowColor = [UIColor lightGrayColor];
    _segment.frame = CGRectMake(0, 0, 320, 0);
    _segment.hidden = NO;
    [self.view addSubview:_segment];
//    [_segment removeAllSegments];
//    for (UIViewController *vc in _viewControllers) {
//        static int i=-1;
//        i++;
//        [_segment insertSegmentWithTitle:vc.title atIndex:i animated:YES];
//    }
    
    _segment.selectedSegmentIndex = 0;
    
    UIViewController *vc = _viewControllers[_segment.selectedSegmentIndex];
    [self addChildViewController:vc];
    if ([self.view.subviews containsObject:vc.view]) {
        [self.view bringSubviewToFront:vc.view];
    }else{
        [self.view addSubview:vc.view];
    }

    vc.view.frame = CGRectMake(0, 50, self.view.width, self.view.height-50);
    [vc didMoveToParentViewController:self];
    [self.view bringSubviewToFront:vc.view];
}
-(id)initWithViewControllers:(NSArray *)vcs
{
    self = [super init];
    self.viewControllers = vcs;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"记录";
    
    self.view.clipsToBounds = YES;
}

-(void)segmentValueChanged
//-(void)segmentValueChanged:(UISegmentedControl*)segment
{
//    for (UIViewController *VC in self.viewControllers) {
//        if (segment.selectedSegmentIndex == [self.viewControllers indexOfObject:VC]) {
//            
//            [self addChildViewController:VC];
//            [self.view addSubview:VC.view];
//            [VC didMoveToParentViewController:self];
//            VC.view.frame = CGRectMake(0, HEIGHT(_segment), SCREEN_FRAME_WIDTH, self.view.frame.size.height- HEIGHT(_segment));
//            [self.view setNeedsDisplay];
//        }
//        else
//        {
//            [VC willMoveToParentViewController:nil];  // 1
//            [VC.view removeFromSuperview];            // 2
//            [VC removeFromParentViewController];      // 3
//            
//            
//        }
//    }
//    [self.view setNeedsDisplay];

    //TODO: this is test！
    if (_segment.selectedSegmentIndex < _viewControllers.count - 1) {
        UIViewController *vc = _viewControllers[_segment.selectedSegmentIndex];
        vc.view.backgroundColor = [UIColor whiteColor];
        [self addChildViewController:vc];
        if ([self.view.subviews containsObject:vc.view]) {
            [self.view bringSubviewToFront:vc.view];
        }else{
            [self.view addSubview:vc.view];
        }
        
        vc.view.frame = CGRectMake(0, 50, self.view.width, SCREEN_HEIGHT - 64 - 50);
        [vc didMoveToParentViewController:self];
    }
//    add liu 20140514
    /*
    if (segment.selectedSegmentIndex <_viewControllers.count) {
        UIViewController *vc = _viewControllers[_segment.selectedSegmentIndex];
        [self addChildViewController:vc];
        if ([self.view.subviews containsObject:vc.view]) {
            [self.view bringSubviewToFront:vc.view];
        }else{
            [self.view addSubview:vc.view];
        }
        
        vc.view.frame = CGRectMake(0, 50, self.view.width, self.view.height-50);
        [vc didMoveToParentViewController:self];
        [self.view setNeedsUpdateConstraints];
   
    }
    */

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
