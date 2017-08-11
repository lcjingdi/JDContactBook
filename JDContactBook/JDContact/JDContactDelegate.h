//
//  JDContactDelegate.h
//  JDContactBook
//
//  Created by jingdi on 2017/8/11.
//  Copyright © 2017年 lcjingdi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>

@interface JDContactDelegate : NSObject<ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic, copy) void(^handler)(NSString *name, NSString *phoneNum);

@end
