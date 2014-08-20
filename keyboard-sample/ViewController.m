//
//  ViewController.m
//  keyboard-sample
//
//  Created by happy_ryo on 2014/08/20.
//  Copyright (c) 2014年 happy_ryo.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    IBOutlet UIScrollView *_scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // NotificationCenter に Keyboard の ON・OFF の通知を追加
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOn:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOff:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardOn:(NSNotification *)notification {
    // 通知からキーボードの高さを取得する
    NSDictionary *userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    // キーボードの高さ分、スクロールビューをスクロールさせる
    CGPoint scrollPoint = CGPointMake(0.0f, keyboardSize.height);
    [_scrollView setContentOffset:scrollPoint animated:YES];
}

- (void)keyboardOff:(NSNotification *)notification {
    // スクロールを元の位置に戻す
    [_scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
