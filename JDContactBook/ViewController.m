//
//  ViewController.m
//  JDContactBook
//
//  Created by jingdi on 2017/8/11.
//  Copyright © 2017年 lcjingdi. All rights reserved.
//

#import "ViewController.h"
#import "JDContactManager.h"

@interface ViewController ()
@property (nonatomic, strong) JDContactManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _manager = [[JDContactManager alloc] init];
    [_manager openContactWithController:self completion:^(NSString *name, NSString *phone) {
        NSLog(@"name->%@, phone->%@", name, phone);
    }];
}

@end
