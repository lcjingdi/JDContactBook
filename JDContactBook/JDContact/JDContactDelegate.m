//
//  JDContactDelegate.m
//  JDContactBook
//
//  Created by jingdi on 2017/8/11.
//  Copyright © 2017年 lcjingdi. All rights reserved.
//

#import "JDContactDelegate.h"

@implementation JDContactDelegate
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    NSLog(@"选中联系人");
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
    
    NSString *fir = CFBridgingRelease(firstName);
    NSString *las = CFBridgingRelease(lastName);
    
    NSString *phoneNumber = nil;
    if (property == kABPersonPhoneProperty) {
        ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
        phoneNumber = (__bridge_transfer NSString *)  ABMultiValueCopyValueAtIndex(multi, identifier);
    } else {
        phoneNumber = @"";
    }
    
    self.handler([NSString stringWithFormat:@"%@%@", fir,las], phoneNumber);
    
}

@end
