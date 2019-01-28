//
//  ViewController.m
//  Runner
//
//  Created by luph on 2019/1/28.
//  Copyright © 2019年 The Chromium Authors. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <Flutter/Flutter.h>

@interface ViewController ()
@property (nonatomic,strong) UIScrollView *scrollview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollview.backgroundColor = [UIColor whiteColor];
    _scrollview.contentSize = CGSizeMake(self.view.bounds.size.width*3, self.view.bounds.size.height);
    _scrollview.pagingEnabled = YES;
    _scrollview.contentOffset = CGPointMake(self.view.bounds.size.width, 0);
    [self.view addSubview:_scrollview];
    
    FlutterEngine *flutterEngine = [(AppDelegate *)[[UIApplication sharedApplication] delegate] flutterEngine];
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [flutterViewController setInitialRoute:@"/main"];
    [self addChildViewController:flutterViewController];
    flutterViewController.view.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.scrollview addSubview:flutterViewController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
