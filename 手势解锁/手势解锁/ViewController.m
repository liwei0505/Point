//
//  ViewController.m
//  手势解锁
//
//  Created by lw on 15/9/7.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "ViewController.h"
#import "unlockButtonView.h"

@interface ViewController ()<unlockButtonView>
@property (weak, nonatomic) IBOutlet unlockButtonView *unlockButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    self.unlockButton.delegate = self;
}

-(BOOL)checkUnlockButton:(unlockButtonView *)unlockButtonView withPassword:(NSMutableString *)password{

    if ([password isEqualToString:@"012"]) {
        return YES;
    }else
        return NO;
}

@end
