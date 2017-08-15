//
//  JDContactManager.m
//  JDContactBook
//
//  Created by jingdi on 2017/8/11.
//  Copyright © 2017年 lcjingdi. All rights reserved.
//

#import "JDContactManager.h"
#import <ContactsUI/ContactsUI.h>
#import <AddressBookUI/AddressBookUI.h>
#import "JDContactDelegate.h"

@interface JDContactManager()<ABPeoplePickerNavigationControllerDelegate>
@property (nonatomic, strong) JDContactDelegate *contactDelegate;
@property (nonatomic, copy) void(^handler)(NSString *name, NSString *phone);
@end

@implementation JDContactManager

- (void)requestAddressBookAuthorization:(void (^)(BOOL authorization))completion {
    
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRef bookRef = ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(bookRef , ^(bool granted, CFErrorRef error) {
            if (completion) {
                completion(granted);
            }
        });
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        completion(YES);
    } else {
        completion(NO);
    }
}
- (void)openContactWithController:(UIViewController *)viewControllerToPresent completion:(void (^)(NSString *name, NSString *phone))completion {
    ABPeoplePickerNavigationController *pvc = [[ABPeoplePickerNavigationController alloc] init];
    pvc.peoplePickerDelegate = self.contactDelegate;
    
    self.handler = ^(NSString *name, NSString *phone) {
        if (completion) {
            completion(name, phone);
        }
    };
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRef bookRef = ABAddressBookCreate();
        [self requestAddressBookAuthorization:^(BOOL authorization) {
            if (authorization) {
                [viewControllerToPresent presentViewController:pvc animated:YES completion:nil];
            } else {
                NSLog(@"error");
            }
        }];
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
        [viewControllerToPresent presentViewController:pvc animated:YES completion:nil];
    }
}

#pragma mark - private

#pragma mark - lazy 
- (JDContactDelegate *)contactDelegate {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *str = [dict objectForKey:@"NSContactsUsageDescription"];
    NSAssert(str.length > 0 , @"This app has crashed because it attempted to access privacy-sensitive data without a usage description.  The app's Info.plist must contain an NSContactsUsageDescription key with a string value explaining to the user how the app uses this data.");
    if (_contactDelegate == nil) {
        _contactDelegate = [[JDContactDelegate alloc] init];
        __weak typeof(self) weakSelf = self;
        _contactDelegate.handler = ^(NSString *name, NSString *phoneNum) {
            weakSelf.handler(name, phoneNum);
        };
        
    }
    return _contactDelegate;
}


@end
