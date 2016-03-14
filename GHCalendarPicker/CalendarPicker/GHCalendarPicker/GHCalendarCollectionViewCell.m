//
//  GHCalendarCollectionViewCell.m
//  GHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "GHCalendarCollectionViewCell.h"

@implementation GHCalendarCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)selectedForLabelColor:(UIColor*)color{
    self.showDayLbl.layer.cornerRadius = self.showDayLbl.frame.size.width/2;
    self.showDayLbl.layer.backgroundColor = color.CGColor;
    self.showDayLbl.textColor = [UIColor whiteColor];

}
-(void)deSelectedForLabelColor:(UIColor*)color{
    self.showDayLbl.layer.backgroundColor = [UIColor clearColor].CGColor;
    self.showDayLbl.textColor = color;
}
-(void)setTodayCellColor:(UIColor*)color{
    self.showDayLbl.layer.cornerRadius = self.showDayLbl.frame.size.width/2;
    self.showDayLbl.layer.backgroundColor = color.CGColor;
    self.showDayLbl.textColor = [UIColor whiteColor];
}
@end
