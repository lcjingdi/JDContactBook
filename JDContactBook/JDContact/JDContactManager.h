//
//  JDContactManager.h
//  JDContactBook
//
//  Created by jingdi on 2017/8/11.
//  Copyright © 2017年 lcjingdi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDContactManager : NSObject

/**
 请求授权
 
 @param completion 回调函数
 */
- (void)requestAddressBookAuthorization:(void (^)(BOOL authorization))completion;

/**
 打开选择联系人
 
 @param viewControllerToPresent 父控制器
 @param completion 完成回调
 */
- (void)openContactWithController:(UIViewController *)viewControllerToPresent completion:(void (^)(NSString *name, NSString *phone))completion;

@end
