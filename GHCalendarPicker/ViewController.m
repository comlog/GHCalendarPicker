//
//  ViewController.m
//  GHCalendarPicker
//
//  Created by Hank on 16/3/14.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "ViewController.h"
#import "GHCalendarPickerViewController.h"

@interface ViewController ()<GHCalendarPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 101, 100);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget: self action:@selector(showBtn) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showBtn {
    
    GHCalendarPickerViewController *viewCOntroller = [[GHCalendarPickerViewController alloc]init:2016 endYear:2017];
    viewCOntroller.startDate = [NSDate date];
    viewCOntroller.hightlightsToday = YES;
    viewCOntroller.calendarDelegate = self;
    viewCOntroller.hideDaysFromOtherMonth = YES;
    viewCOntroller.backgroundColor = [UIColor whiteColor];
    viewCOntroller.tintColor = [UIColor orangeColor];
    viewCOntroller.dayDisabledTintColor = [UIColor grayColor];
    viewCOntroller.hightlightsToday = YES;
    viewCOntroller.dayDisabledTintColor = [UIColor lightGrayColor];
    viewCOntroller.weekdayTintColor = [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1];
    viewCOntroller.weekendTintColor = [UIColor colorWithRed:192/255.0 green:57/255.0 blue:43/255.0 alpha:1];
    viewCOntroller.dateSelectionColor = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1];
    viewCOntroller.monthTitleColor = [UIColor colorWithRed:211/255.0 green:84/255.0 blue:0/255.0 alpha:1];
    viewCOntroller.todayTintColor = [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:viewCOntroller];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
