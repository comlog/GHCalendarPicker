//
//  GHCalendarHeaderView.h
//  GHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHCalendarHeaderView : UICollectionReusableView

@property(nonatomic,strong)IBOutlet UILabel *lblFirst;
@property(nonatomic,strong)IBOutlet UILabel *lblSecond;
@property(nonatomic,strong)IBOutlet UILabel *lblThird;
@property(nonatomic,strong)IBOutlet UILabel *lblFourth;
@property(nonatomic,strong)IBOutlet UILabel *lblFifth;
@property(nonatomic,strong)IBOutlet UILabel *lblSixth;
@property(nonatomic,strong)IBOutlet UILabel *lblSeventh;
@property(nonatomic,strong)IBOutlet UILabel *lblTitle;

-(void)updateWeekendLabelColor:(UIColor*)color;
-(void)updateWeekdaysLabelColor:(UIColor*)color;

@end
