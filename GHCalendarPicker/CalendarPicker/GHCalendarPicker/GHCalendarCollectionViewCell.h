//
//  GHCalendarCollectionViewCell.h
//  CHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHCalendarCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *showDayLbl;
@property (nonatomic,strong)NSDate *currentDate;
@property (nonatomic,assign)BOOL isCellSelectable;

-(void)selectedForLabelColor:(UIColor*)color;
-(void)deSelectedForLabelColor:(UIColor*)color;
-(void)setTodayCellColor:(UIColor*)color;

@end
