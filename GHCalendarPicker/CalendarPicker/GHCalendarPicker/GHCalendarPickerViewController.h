//
//  GHCalendarPickerViewController.h
//  GHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GHCalendarPickerViewController;
@protocol GHCalendarPickerDelegate <NSObject>

@optional
/**
 *  日历 取消
 *
 *  @param calendarPick 日历控件
 *  @param error        取消原因
 */
-(void)calendarPickDidCancel:(GHCalendarPickerViewController*)calendarPick error:(NSError*)error;
/**
 *  日历 选中 单个日期
 *
 *  @param calendarPick 日历控件
 *  @param date         选中日期
 */
-(void)calendarPickDidSelectDate:(GHCalendarPickerViewController*)calendarPick date:(NSDate*)date;
/**
 *  日历 选中 多个日期
 *
 *  @param calendarPick 日历控件
 *  @param dateArray    选中日期 数组
 */
-(void)calendarPickDidSelectMultipleDate:(GHCalendarPickerViewController*)calendarPick dates:(NSArray*)dateArray;

@end
@interface GHCalendarPickerViewController : UICollectionViewController<GHCalendarPickerDelegate>

@property (nonatomic,assign) id <GHCalendarPickerDelegate>calendarDelegate;
@property (nonatomic,assign) BOOL multiSelectEnabled;
@property (nonatomic,assign) BOOL showsTodaysButton;
@property (nonatomic,strong) NSMutableArray * arrSelectedDates;
@property (nonatomic,strong) UIColor * tintColor;
@property (nonatomic,strong) UIColor * dayDisabledTintColor;
@property (nonatomic,strong) UIColor * weekdayTintColor;
@property (nonatomic,strong) UIColor * weekendTintColor;
@property (nonatomic,strong) UIColor * todayTintColor;
@property (nonatomic,strong) UIColor * dateSelectionColor;
@property (nonatomic,strong) UIColor * monthTitleColor;
@property (nonatomic,strong) NSDate * startDate;
@property (nonatomic,assign) BOOL hightlightsToday;
@property (nonatomic,assign) BOOL hideDaysFromOtherMonth;
@property (nonatomic,strong) UIColor * backgroundColor;

/**
 *  初始化
 *
 *  @param startYear      开始年
 *  @param endYear        结束年
 *  @param multiSelection 是否多选
 *  @param dateArr        选中的日期
 */
-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear multiSelection:(BOOL)multiSelection selectedDates:(NSArray*)dateArr;

/**
 *  初始化
 *
 *  @param startYear     开始年
 *  @param endYear       结束年
 *  @param multiSelectio 是否多选
 */
-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear multiSelection:(BOOL)multiSelectio;

/**
 *  初始化
 *
 *  @param startYear 开始年
 *  @param endYear   结束年
 */
-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear;

/**
 *  回到指定的日期
 *
 *  @param date 
 */
-(void)scrollToMonthForDate:(NSDate*)date;
@end
