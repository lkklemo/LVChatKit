//
//  LVLoginController.m
//  LVChatKit
//
//  Created by 宇航 on 16/11/28.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "LVLoginController.h"
#import "MBProgressHUD.h"
#import "UIViewExt.h"
#import "LCChatKit.h"
@interface LVLoginController ()<UITextFieldDelegate>
{
    UIScrollView *_scrollView;
    BOOL _keyboardShown;
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    CGFloat _previousKeyboardHeight;
    MBProgressHUD *_hud;
    
}
@end

@implementation LVLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    _previousKeyboardHeight = CGFLOAT_MIN;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 291)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [topView addSubview:imageView];
    imageView.center = CGPointMake(topView.center.x, topView.center.y + 15);
    
    [scrollView addSubview:topView];
    _scrollView = scrollView;
    
    //用户名标题
    CGFloat marginX = 25;
    CGFloat userNameTitleLabelX = marginX;
    CGFloat userNameTitleLabelY = CGRectGetMaxY(topView.frame);
    UILabel *userNameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(userNameTitleLabelX, userNameTitleLabelY, screenWidth-marginX*2, 13)];

    userNameTitleLabel.text = @"请输入用户名";
    _usernameTextField = [self addTextFieldPlaceholder:@"请输入用户名或邮箱" imageName:@"login_username_textField_icon" frame:CGRectMake(userNameTitleLabelX, 160, screenWidth-marginX*2, 40)];
    _usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField = [self addTextFieldPlaceholder:@"请输入密码" imageName:@"login_password_textField_icon" frame:CGRectMake(userNameTitleLabelX, CGRectGetMaxY(_usernameTextField.frame) + 15, screenWidth-marginX*2, 40)];
    _passwordTextField.secureTextEntry = YES;
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat loginButtonX = marginX;
    CGFloat loginButtonY = _passwordTextField.bottom+15;
    CGFloat loginButtonH = 40;
    loginButton.frame = CGRectMake(loginButtonX, loginButtonY, screenWidth-marginX*2, loginButtonH);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
//    loginButton.titleLabel.font = [UIFont fontWithName:KHFontDefault size:17];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"login_button_background"] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor purpleColor];
    [loginButton.layer setMasksToBounds:YES];
    [loginButton.layer setCornerRadius:6]; //设置矩形四个圆角半径
    [loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginButton];
    scrollView.contentSize = CGSizeMake(320, 500);
    [self.view addSubview:scrollView];
    _usernameTextField.text = @"super";
    _passwordTextField.text = @"123456";
}

- (UITextField *)addTextFieldPlaceholder:(NSString *)placeholder imageName:(NSString *)imageName frame:(CGRect)frame
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;

    textField.delegate = self;
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *accountView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 14, 14)];
    accountView.image = image;
    
    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, accountView.size.width + 10, accountView.size.height)];
    [imageView addSubview:accountView];
    textField.leftView = imageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:textField];
    return textField;
}

- (void)loginButtonClicked:(UIButton*)btn{
    [[LCChatKit sharedInstance] openWithClientId:_usernameTextField.text callback:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"succeeded");
        }else{
            NSLog(@"fail");
        }
        
    }];
}

@end
