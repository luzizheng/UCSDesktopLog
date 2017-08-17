//
//  ViewController.m
//  UCSDesktopLog
//
//  Created by Luzz on 2017/8/14.
//  Copyright © 2017年 UCS. All rights reserved.
//

#import "ViewController.h"
#import "UCSDesktopLog.h"
#import "Person.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)update:(id)sender {
    Person * p = [[Person alloc] init];
    p.name = @"fuck you";
    p.sex = 2;
    [UCSDesktopLog updateLogWithFileName:@"测试日志.log" andLog:p];
}
- (IBAction)insert:(id)sender {
    [UCSDesktopLog insertLogWithFileName:@"测试日志.log" andLog:_tf.text];
}


@end
