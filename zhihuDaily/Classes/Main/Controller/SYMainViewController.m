//
//  ViewController.m
//  zhihuDaily
//
//  Created by yang on 16/2/21.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "SYMainViewController.h"
#import "SYTheme.h"
#import "SYHomeController.h"
#import "SYZhihuTool.h"
#import "MJExtension.h"
#import "SYThemeController.h"
#import "SYLeftDrawerController.h"
#import "SYThemeController.h"
@interface SYMainViewController ()

@end

@implementation SYMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.maximumLeftDrawerWidth = 200;
    self.shouldStretchDrawer = NO;
    self.showsShadow = NO;
  
    
    [kNotificationCenter addObserver:self selector:@selector(openDrawer) name:OpenDrawer object:nil];
    [kNotificationCenter addObserver:self selector:@selector(closeDrawer) name:CloseDrawer object:nil];
    [kNotificationCenter addObserver:self selector:@selector(toggleDrawer) name:ToggleDrawer object:nil];

    SYLeftDrawerController *drawerController = [[SYLeftDrawerController alloc] init];
    
    UINavigationController *homeController = [drawerController naviHome];
    
    drawerController.mainController = self;
    
    self.centerViewController = homeController;
    self.leftDrawerViewController = drawerController;
    
    self.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
}



- (void)openDrawer {
    [self openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)closeDrawer {
    [self closeDrawerAnimated:YES completion:nil];

}

- (void)toggleDrawer {
    if (self.openSide == MMDrawerSideNone) {
        [self openDrawer];
    } else {
        [self closeDrawer];
    }
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self];
}





@end
