//
//  unlockButtonView.h
//  手势解锁
//
//  Created by lw on 15/9/7.
//  Copyright © 2015年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class unlockButtonView;
@protocol unlockButtonView <NSObject>

-(BOOL)checkUnlockButton:(unlockButtonView *)unlockButtonView withPassword:(NSMutableString *)password;

@end

@interface unlockButtonView : UIView

@property (nonatomic,assign)id<unlockButtonView> delegate;

@end
