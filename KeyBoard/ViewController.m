//
//  ViewController.m
//  KeyBoard
//
//  Created by 换一换 on 16/2/25.
//  Copyright © 2016年 张洋. All rights reserved.
//

#import "ViewController.h"
#import "KeyBoardHepler.h"
#define kHeight      [[UIScreen mainScreen] bounds].size.height
#define kWidth       [[UIScreen mainScreen] bounds].size.width
@interface ViewController ()<KeyBoardDelegate>
@property (nonatomic, strong) UITextField *text;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _text = [[UITextField alloc] initWithFrame:CGRectMake(0, kHeight - 50, kWidth, 50)];
    _text.backgroundColor
    = [UIColor redColor];
    _text.placeholder = @"点击输入内容";
    [self.view addSubview:_text];
    
    [KeyBoardHepler registerKeyBoardShow:self];
    [KeyBoardHepler registerKeyBoardDismiss:self];
}
-(void)keyBoardWillShowNotification:(NSNotification *)notification
{
    CGRect keyboardEndFrameWindow = [KeyBoardHepler getKeyBoardWindow:notification];
    double keyBoardTransitionDuration = [KeyBoardHepler getKeyBoardDuration:notification];
    UIViewAnimationCurve keyBoarTransitionAnimationCurve = [KeyBoardHepler getKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:keyBoardTransitionDuration delay:0 options:keyBoarTransitionAnimationCurve << 16 animations:^{
        CGRect frame = CGRectMake(0, kHeight - 50, kWidth, 50);
        frame.origin.y -= keyboardEndFrameWindow.size.height;
        self.text.frame = frame;
    } completion:nil];
    
}
-(void)keyBoardWillDismissNotification:(NSNotification *)notification
{
    CGRect keyboardEndFrameWindow = [KeyBoardHepler getKeyBoardWindow:notification];
    double keyBoardTransitionDuration = [KeyBoardHepler getKeyBoardDuration:notification];
    UIViewAnimationCurve keyBoarTransitionAnimationCurve = [KeyBoardHepler getKeyBoardAnimationCurve:notification];
    [UIView animateWithDuration:keyBoardTransitionDuration delay:0 options:keyBoarTransitionAnimationCurve << 16 animations:^{
        CGPoint center = self.text.center;
        center.y += keyboardEndFrameWindow.size.height;
        self.text.center = center;
    } completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
