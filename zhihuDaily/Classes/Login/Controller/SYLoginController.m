//
//  SYLoginController.m
//  zhihuDaily
//
//  Created by yang on 16/3/2.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "SYLoginController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD+YS.h"
#import "SYZhihuTool.h"
#import "SYAccount.h"

@interface SYLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation SYLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    RAC(self.loginButton, enabled) = [RACSignal combineLatest:@[self.nameLabel.rac_textSignal, self.password.rac_textSignal] reduce:^id(NSString *x1, NSString *x2){
        return @(x1.length>0 && x2.length>0);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    BOOL result = [SYAccount loginWithName:self.nameLabel.text password:self.password.text];
    
    if (result) {
        [MBProgressHUD showSuccess:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
        
        SYAccount *account = [SYAccount sharedAccount];
        
        NSLog(@"--> %@ %@, %d", account.name, account.avatar, account.isLogin);
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [MBProgressHUD showSuccess:@"请输入正确的用户名和密码"];
    }
}


@end
