//
//  GHCalendarPickerViewController.m
//  GHCalendarPicker
//
//  Created by Hank on 16/3/11.
//  Copyright © 2016年 GH. All rights reserved.
//

#import "GHCalendarPickerViewController.h"

#import "GHCalendarCollectionViewCell.h"
#import "GHCalendarHeaderView.h"
#import "GHDateTools.h"

@interface GHCalendarPickerViewController ()
@property (nonatomic,assign) NSInteger startYear;
@property (nonatomic,assign) NSInteger endYear;

@end

@implementation GHCalendarPickerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    UINib *cellxib = [UINib nibWithNibName:@"GHCalendarCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellxib forCellWithReuseIdentifier:@"GHCalendarCollectionViewCell"];
        
    UINib *headerxib = [UINib nibWithNibName:@"GHCalendarHeaderView" bundle:nil];
    [self.collectionView registerNib:headerxib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHCalendarHeaderView"];
    
    if (self.backgroundColor) {
        self.view.backgroundColor = self.backgroundColor;

    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }

    // Do any additional setup after loading the view.
    [self setUpCollectionView];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToToday];
    });
    
}
// setup collectionview
-(void)setUpCollectionView{
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}


-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear multiSelection:(BOOL)multiSelection selectedDates:(NSArray*)dateArr{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing =1;
    layout.minimumLineSpacing =1;
    layout.headerReferenceSize = CGSizeMake(100,60);
    
    self = [super initWithCollectionViewLayout:layout];
    
    if (self) {
        
        self.startYear = startYear;
        self.endYear = endYear;
        self.multiSelectEnabled = multiSelection;
    
        if (dateArr) {
            self.arrSelectedDates = [[NSMutableArray alloc]initWithArray:dateArr];
        }else{
            self.arrSelectedDates = [[NSMutableArray alloc]init];
        }
    }
    return self;
    
}
-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear multiSelection:(BOOL)multiSelectio{
    
    self = [self init:startYear endYear:endYear multiSelection:multiSelectio selectedDates:nil];
    
    if (self) {
        
    }
    return self;
}
-(instancetype)init:(NSInteger)startYear endYear:(NSInteger)endYear{

    self = [self init:startYear endYear:endYear multiSelection:NO selectedDates:nil];
    
    if (self) {
        
    }
    return self;
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.startYear>self.endYear) {
        return 0;
    }
    NSInteger numberOfMonths = 12 * (self.endYear - self.startYear) + 12;
    return numberOfMonths;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSDate *startDate  = [GHDateTools init:self.startYear month:1 day:1];
    NSDate * firstDayOfMonth = [GHDateTools dateByAddingMonths:startDate andMonth:section];
    NSInteger addingPrefixDaysWithMonthDyas = [GHDateTools numberOfDaysInMonth:firstDayOfMonth]+[GHDateTools weekday:firstDayOfMonth]-[NSCalendar currentCalendar].firstWeekday;
    NSInteger addingSuffixDays = addingPrefixDaysWithMonthDyas%7;
    NSInteger totalNumber = addingPrefixDaysWithMonthDyas;
    if (addingSuffixDays!=0) {
        totalNumber = totalNumber+(7-addingSuffixDays);
    }
    return totalNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GHCalendarCollectionViewCell *cell = (GHCalendarCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"GHCalendarCollectionViewCell" forIndexPath:indexPath];
    
    NSDate *calendarStartDate  = [GHDateTools init:self.startYear month:1 day:1];
    
    NSDate * firstDayOfThisMonth = [GHDateTools dateByAddingMonths:calendarStartDate andMonth:indexPath.section];
    
    NSInteger prefixDays = [GHDateTools weekday:firstDayOfThisMonth ]-[NSCalendar currentCalendar].firstWeekday;
    
    if (indexPath.row>=prefixDays) {
        
        cell.isCellSelectable = YES;
        NSDate *currentDate = [GHDateTools dateByAddingDays:firstDayOfThisMonth day:(indexPath.row-prefixDays)];
        
        NSInteger numberOfdaysInMonth = [GHDateTools numberOfDaysInMonth:firstDayOfThisMonth]-1;
        
        NSDate* nextMonthFirstDay = [GHDateTools dateByAddingDays:firstDayOfThisMonth day:numberOfdaysInMonth];
        cell.currentDate = currentDate;
        
        cell.showDayLbl.text = [NSString stringWithFormat:@"%ld",(long)[GHDateTools day:currentDate]];
        
        NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"SELF==%@",currentDate];
        
        if (([self.arrSelectedDates filteredArrayUsingPredicate:thePredicate].count>0)&&([GHDateTools month:firstDayOfThisMonth]==[GHDateTools month:currentDate])) {
            [cell selectedForLabelColor:self.dateSelectionColor];
        }else{
            [cell deSelectedForLabelColor:self.weekdayTintColor];
            if (([GHDateTools isSaturday:currentDate])||[GHDateTools isSunday:cell.currentDate]) {
                cell.showDayLbl.textColor = self.weekendTintColor;
            }
            if (currentDate > nextMonthFirstDay) {
                cell.isCellSelectable = NO;
                if (self.hideDaysFromOtherMonth) {
                    cell.showDayLbl.textColor = [UIColor clearColor];
                }else
                {
                    cell.showDayLbl.textColor = self.dayDisabledTintColor;
                }
            }
            if (([GHDateTools isToday:currentDate])&&self.hightlightsToday) {
                [cell setTodayCellColor:self.todayTintColor];
            }
            if (self.startDate!=nil) {
                if (([[NSCalendar currentCalendar] startOfDayForDate:cell.currentDate])<([[NSCalendar currentCalendar] startOfDayForDate:self.startDate])) {
                    cell.isCellSelectable = NO;
                    cell.showDayLbl.textColor = self.dayDisabledTintColor;
                }
            }
        }
        
    }else{
        [cell deSelectedForLabelColor:self.weekdayTintColor];
        cell.isCellSelectable = NO;
        
        NSDate *previousDay = [GHDateTools dateByAddingDays:firstDayOfThisMonth day:(indexPath.row-prefixDays)];
        cell.currentDate = previousDay;
        cell.showDayLbl.text = [NSString stringWithFormat:@"%ld",(long)[GHDateTools day:previousDay]];
        if (self.hideDaysFromOtherMonth) {
            cell.showDayLbl.textColor = [UIColor clearColor];
        }else{
            cell.showDayLbl.textColor = self.dayDisabledTintColor;
        }
        

    }

    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
// 设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect bonds = [UIScreen mainScreen].bounds;
    return CGSizeMake((bonds.size.width-7)/7, (bonds.size.width-7)/7);
}

// 设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets top = {5,0,5,0};
    return top;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind==UICollectionElementKindSectionHeader) {
        
       GHCalendarHeaderView *header =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GHCalendarHeaderView" forIndexPath:indexPath];
        NSDate * startDate =[GHDateTools init:self.startYear month:1 day:1];
        NSDate * firstDayOfMonth = [GHDateTools dateByAddingMonths:startDate andMonth:indexPath.section];
        header.lblTitle.text = [GHDateTools monthNameFull:firstDayOfMonth];
        header.lblTitle.textColor = self.monthTitleColor;
        [header updateWeekdaysLabelColor:self.weekdayTintColor];
        [header updateWeekendLabelColor:self.weekendTintColor];
        header.backgroundColor = [UIColor clearColor];
        return header;
    }
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GHCalendarCollectionViewCell *cell =(GHCalendarCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    
    if (!self.multiSelectEnabled) {
        
        if (self.calendarDelegate&&[self.calendarDelegate respondsToSelector:@selector(calendarPickDidSelectDate:date:)]) {
            
            [self.calendarDelegate calendarPickDidSelectDate:self date:cell.currentDate];
            [cell selectedForLabelColor:self.dateSelectionColor];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            return;
        }
    }
    
    if (cell.isCellSelectable) {
        
        NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"SELF==%@",cell.currentDate];

        if ([self.arrSelectedDates filteredArrayUsingPredicate:thePredicate].count==0){
        
            [self.arrSelectedDates addObject:cell.currentDate];
            [cell selectedForLabelColor:self.dateSelectionColor];
            
            if ([GHDateTools isToday:cell.currentDate]) {
                [cell setTodayCellColor:self.dateSelectionColor];
            }
        }else{
            NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"SELF!=%@",cell.currentDate];
            
            NSArray * inArray =  [self.arrSelectedDates filteredArrayUsingPredicate:thePredicate];
            
            if (self.arrSelectedDates.count>0) {
                [self.arrSelectedDates removeAllObjects];
            }
            [self.arrSelectedDates addObjectsFromArray:inArray];
            if ([GHDateTools isSaturday:cell.currentDate]||[GHDateTools isSunday:cell.currentDate]) {
                [cell deSelectedForLabelColor:self.weekendTintColor];
            }else{
                [cell deSelectedForLabelColor:self.weekdayTintColor];

            }
            if ([GHDateTools isToday:cell.currentDate]&&self.hightlightsToday) {
                [cell setTodayCellColor:self.todayTintColor];
            }
        }
    }
}

#pragma mark =========回到今天
-(void)scrollToToday{
    NSDate * curDate = [NSDate date];
    [self scrollToMonthForDate:curDate];
}
#pragma mark =========回到具体的日期
-(void)scrollToMonthForDate:(NSDate*)date{
    
    NSInteger month =  [GHDateTools month:date];
    NSInteger year =  [GHDateTools year:date];
    NSInteger section =   ((year - self.startYear) * 12) + month;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:section-1];
    
    NSInteger sections =  self.collectionView.numberOfSections;
    
        if (indexPath.section <= sections){
          UICollectionViewLayoutAttributes *  attributes = [self.collectionView layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
            
            CGPoint topOfHeader = CGPointMake(0, attributes.frame.origin.y - self.collectionView.contentInset.top);
            [self.collectionView setContentOffset:topOfHeader animated:NO];
        }
    
}

@end
