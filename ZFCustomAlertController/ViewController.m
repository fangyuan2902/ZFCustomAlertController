//
//  ViewController.m
//  ZFCustomAlertController
//
//  Created by mac on 2019/1/30.
//  Copyright © 2019年 k. All rights reserved.
//

#import "ViewController.h"
#import "ZFCustomAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ZFCustomAlertController *alertController = [ZFCustomAlertController alertWithTitle:@"免费用户每天最多导入5次" andContent:nil];
    ZFAlertAction *alertAction1 = [ZFAlertAction actionWithTitle:@"导入" andTitleColor:[UIColor greenColor] action:^{
        
    }];
    ZFAlertAction *cancelAction = [ZFAlertAction actionWithTitle:@"开通会员" andTitleColor:[UIColor lightGrayColor] action:^{
        
    }];
    [alertController addAction:alertAction1];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
