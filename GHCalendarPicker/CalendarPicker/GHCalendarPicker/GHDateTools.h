//
//  GHDateTools.h
//  GHCalendarPicker
//
//  Created by Hank on 16/3/12.
//  Copyright © 2016年 GH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHDateTools : NSObject

/**
 *  获取指定年、月、日的日期
 *
 *  @param year  年
 *  @param month 月
 *  @param day   日
 *
 *  @return
 */
+(NSDate*)init:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/**
 *  根据某个日期 获得几个月后的日期
 *
 *  @param startDate 某日期
 *  @param month     月数
 *
 *  @return
 */
+(NSDate*)dateByAddingMonths:(NSDate*)startDate andMonth:(NSInteger)month;

/**
 *  获取指定日期，月份的天数
 *
 *  @param date 指定日期
 *
 *  @return
 */
+(NSInteger)numberOfDaysInMonth:(NSDate*)date;

/**
 *  获取指定时间是星期中的哪天 默认星期日为第一天
 *
 *  @param date 指定时间
 *
 *  @return
 */
+(NSInteger)weekday:(NSDate*)date;
/**
 *  获取指定时间是一天中的哪个小时
 *
 *  @param date 指定时间
 *
 *  @return
 */
+(NSInteger)hour:(NSDate*)date;
/**
 *  获取指定时间是一小时中的第多少秒
 *
 *  @param date 指定时间
 *
 *  @return
 */
+(NSInteger)second:(NSDate*)date;
/**
 *  获取指定时间是一小时中的第多少分
 *
 *  @param date 指定时间
 *
 *  @return
 */
+(NSInteger)minute:(NSDate*)date;
/**
 *  获取指定时间是一个月中的第多少天
 *
 *  @param date 指定日期
 *
 *  @return
 */
+(NSInteger)day:(NSDate*)date;
/**
 *  获取指定时间是一年中的第多少月
 *
 *  @param date 指定日期
 *
 *  @return
 */
+(NSInteger)month:(NSDate*)date;
/**
 *  获取指定时间的年数
 *
 *  @param date 指定时间
 *
 *  @return
 */
+(NSInteger)year:(NSDate*)date;

/**
 *  获取指定日期 几天后的日期
 *
 *  @param date 指定日期
 *  @param day  几天
 *
 *  @return
 */
+(NSDate*)dateByAddingDays:(NSDate*)date day:(NSInteger)day;

/**
 *  判断俩个日期是否是同一天
 *
 *  @param date    比较日期一
 *  @param twoDate 比较日期二
 *
 *  @return
 */
+(BOOL)isDateSameDay:(NSDate*)date andTwoDate:(NSDate*)twoDate;

/**
 *  判断星期几
 *
 *  @param date 指定日期
 *
 *  @return
 */
+(BOOL)isSaturday:(NSDate*)date;
+(BOOL)isFriday:(NSDate*)date;
+(BOOL)isThursday:(NSDate*)date;
+(BOOL)isWednesday:(NSDate*)date;
+(BOOL)isTuesday:(NSDate*)date;
+(BOOL)isMonday:(NSDate*)date;
+(BOOL)isSunday:(NSDate*)date;
+(BOOL)isToday:(NSDate*)date;

/**
 *  一个星期中的第几天
 *
 *  @param date 指定日期
 *
 *  @return 
 */
+(NSInteger)getWeekday:(NSDate*)date;

/**
 *  获取指定日期 返回来的年、月日期 例如：三月 2016
 *
 *  @param date 指定日期
 *
 *  @return 
 */
+(NSString*)monthNameFull:(NSDate*)date;
@end
