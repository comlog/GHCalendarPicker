//
//  GHCalendarHeaderView.m
//  GHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "GHCalendarHeaderView.h"

@implementation GHCalendarHeaderView

- (void)awakeFromNib {
    // Initialization code
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSArray * weeksDayList = calendar.shortWeekdaySymbols;
    if (calendar.firstWeekday==2) {
       self.lblFirst.text = weeksDayList[1];
        self.lblSecond.text = weeksDayList[2];
        self.lblThird.text = weeksDayList[3];
        self.lblFourth.text = weeksDayList[4];
        self.lblFifth.text = weeksDayList[5];
        self.lblSixth.text = weeksDayList[6];
        self.lblSeventh.text = weeksDayList[0];
    } else {
        self.lblFirst.text = weeksDayList[0];
        self.lblSecond.text = weeksDayList[1];
        self.lblThird.text = weeksDayList[2];
        self.lblFourth.text = weeksDayList[3];
        self.lblFifth.text = weeksDayList[4];
        self.lblSixth.text = weeksDayList[5];
        self.lblSeventh.text = weeksDayList[6];
    }

}

-(void)updateWeekendLabelColor:(UIColor*)color{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    if (calendar.firstWeekday==2) {
        self.lblSixth.textColor = color;
        self.lblSeventh.textColor = color;
    } else {
        self.lblFirst.textColor = color;
        self.lblSeventh.textColor = color;
    }

}
-(void)updateWeekdaysLabelColor:(UIColor*)color{
    NSCalendar * calendar = [NSCalendar currentCalendar];
    if (calendar.firstWeekday==2) {
        self.lblFirst.textColor = color;
        self.lblSecond.textColor = color;
        self.lblThird.textColor = color;
        self.lblFourth.textColor = color;
        self.lblFifth.textColor = color;
    } else {
        self.lblSecond.textColor = color;
        self.lblThird.textColor = color;
        self.lblFourth.textColor = color;
        self.lblFifth.textColor = color;
        self.lblSixth.textColor = color;
    }

}

@end
