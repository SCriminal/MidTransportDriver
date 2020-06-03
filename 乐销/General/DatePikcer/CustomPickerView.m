//
//  CustomPickerView.m
//中车运
//
//  Created by 隋林栋 on 2017/3/30.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CustomPickerView.h"
#import "DatePicker.h"




// Identifies for component views
#define LABEL_TAG 43

@interface CustomPickerView()

@property (nonatomic, strong) NSArray *months;
@property (nonatomic, assign) NSInteger yearComponent;
@property (nonatomic, assign) NSInteger monthComponent;
@property (nonatomic, assign) NSInteger dayComponent;
@property (nonatomic, assign) NSInteger hourComponent;
@property (nonatomic, assign) NSInteger minComponent;


@property (nonatomic, strong) NSArray *years;
@property (nonatomic, readonly) NSString *(^yearFromAry)(NSInteger);
@property (nonatomic, readonly) NSString *(^monthFromAry)(NSInteger);
@property (nonatomic, readonly) NSString *(^dayFromAry)(NSInteger);

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSArray *hours;
@property (nonatomic, strong) NSArray *mins;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSCalendar *calendar;

@property (nonatomic, assign) NSInteger minYear;
@property (nonatomic, assign) NSInteger maxYear;
@property (nonatomic, assign) NSInteger numberOfComponent;
@property (nonatomic, assign) int datePickerMode;

@property (nonatomic, strong) NSDateFormatter *formatter;


@end

@implementation CustomPickerView



#pragma mark - Properties
- (NSInteger)numberOfComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return 2;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return 3;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return 4;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 5;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return 2;
        default:
            break;
    }
    return -1;
}
- (NSInteger)yearComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return 0;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return 0;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return 0;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 0;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return -1;
        default:
            break;
    }
    return -1;
}
- (NSInteger)monthComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return 1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return 1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return 1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 1;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return 0;
        default:
            break;
    }
    return -1;
}
- (NSInteger)dayComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return 2;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return 2;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 2;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return 1;
        default:
            break;
    }
    return -1;
}
- (NSInteger)hourComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return 3;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 3;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return -1;
        default:
            break;
    }
    return -1;
}
- (NSInteger)minComponent{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
            return -1;
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
            return 4;
        case ENUM_PICKER_DATE_MONTH_DAY:
            return -1;
        default:
            break;
    }
    return -1;
}
- (NSString *(^)(NSInteger))yearFromAry{
    return ^(NSInteger index){
        return [self.years safe_objectAtIndex:index]?:[GlobalMethod exchangeDate:[NSDate date] formatter:@"yyyy年"];
    };
}
- (NSString *(^)(NSInteger))monthFromAry{
    return ^(NSInteger index){
        return [self.months safe_objectAtIndex:index]?:[GlobalMethod exchangeDate:[NSDate date] formatter:@"M月"];
    };
}
- (NSString *(^)(NSInteger))dayFromAry{
    return ^(NSInteger index){
        return [self.days safe_objectAtIndex:index]?:[GlobalMethod exchangeDate:[NSDate date] formatter:@"d日"];
    };
}
#pragma mark - Init

-(instancetype)initWithDatePickerMode:(int)datePickerMode MinDate:(NSDate *)minDate MaxDate:(NSDate *)maxDate
{
    if (self = [super init])
    {
        self.width = SCREEN_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
        self.datePickerMode = datePickerMode;
        if (minDate && [minDate isKindOfClass:NSDate.class]) {
            [self setMinDate:[GlobalMethod exchangeStringToDate:[NSDate stringWithDate:minDate format:TIME_DAY_SHOW] formatter:TIME_DAY_SHOW]];
        }else{
            [self setMinDate:[GlobalMethod exchangeStringToDate:@"1890-01-01" formatter:TIME_DAY_SHOW]];
        }
        [self setMaxDate:[self extractDayDate:[NSDate dateWithTimeIntervalSince1970:4102416000]]];
        
        [self loadDefaultsParameters];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self loadDefaultsParameters];
}

#pragma mark - Open methods

-(NSDate *)date
{
    switch (self.datePickerMode) {
        case ENUM_PICKER_DATE_YEAR_MONTH:
        {
            NSString *year =  self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
            NSString *month =  self.monthFromAry(([self selectedRowInComponent:self.monthComponent]));
            return [GlobalMethod exchangeStringToDate:[NSString stringWithFormat:@"%@%@", year, month] formatter:@"yyyy年M月"];
        }
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY:
        {
            NSString *year =  self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
            NSString *month =  self.monthFromAry(([self selectedRowInComponent:self.monthComponent]));
            NSString *day =  self.dayFromAry(([self selectedRowInComponent:self.dayComponent]));
            return [GlobalMethod exchangeStringToDate:[NSString stringWithFormat:@"%@%@%@", year, month, day] formatter:@"yyyy年M月d日"];
        }
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR:
        {
            NSString *year =  self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
            NSString *month =  self.monthFromAry(([self selectedRowInComponent:self.monthComponent]));
            NSString *day =  self.dayFromAry(([self selectedRowInComponent:self.dayComponent]));
            NSString *hour =  [self.hours safe_objectAtIndex:([self selectedRowInComponent:self.hourComponent])];
            return [GlobalMethod exchangeStringToDate:[NSString stringWithFormat:@"%@%@%@%@", year, month, day, hour] formatter:@"yyyy年M月d日H时"];
        }
        case ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN:
        {
            NSString *year =  self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
            NSString *month =  self.monthFromAry(([self selectedRowInComponent:self.monthComponent]));
            NSString *day =  self.dayFromAry(([self selectedRowInComponent:self.dayComponent]));
            NSString *hour =  [self.hours safe_objectAtIndex:([self selectedRowInComponent:self.hourComponent])];
            NSString *min =  [self.mins safe_objectAtIndex:([self selectedRowInComponent:self.minComponent])];
            return [GlobalMethod exchangeStringToDate:[NSString stringWithFormat:@"%@%@%@%@%@", year, month, day, hour, min] formatter:@"yyyy年M月d日H时m分"];
        }
        case ENUM_PICKER_DATE_MONTH_DAY:
        {
            NSString *month =  self.monthFromAry(([self selectedRowInComponent:self.monthComponent]));
            NSString *day =  self.dayFromAry(([self selectedRowInComponent:self.dayComponent]));
            return [GlobalMethod exchangeStringToDate:[NSString stringWithFormat:@"%@%@", month, day] formatter:@"M月d日"];
        }
        default:
            break;
    }
    return [NSDate date];
}



-(NSDate *)monthDate
{
    //    NSInteger monthCount = self.months.count;
    NSInteger indexMonth = ([self selectedRowInComponent:self.monthComponent]);
    NSString *month = self.monthFromAry(indexMonth);
    //    NSInteger yearCount = self.years.count;
    NSString *year = self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy年M月"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@%@", year, month]];
    
    return date;
}

-(NSDate *)yearDate
{
    //    NSInteger yearCount = self.years.count;
    NSString *year = self.yearFromAry([self selectedRowInComponent:self.yearComponent]);
    NSDateFormatter *formatter = [NSDateFormatter new];
    //    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:@"yyyy年"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@", year]];
    
    return date;
}

- (void)setupMinYear:(NSInteger)minYear maxYear:(NSInteger)maxYear
{
    self.minYear = minYear;
    
    
    if (maxYear > minYear)
    {
        self.maxYear = maxYear;
    }
    else
    {
        self.maxYear = 2099;
    }
    
    self.years = [self nameOfYears];
}


#pragma mark - UIPickerViewDelegate

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return [self componentWidth];
}

-(UIView *)pickerView: (UIPickerView *)pickerView viewForRow: (NSInteger)row forComponent: (NSInteger)component reusingView: (UIView *)view
{
    BOOL selected = NO;
    if(component == self.monthComponent)
    {
        NSInteger monthCount = self.months.count;
        NSString *monthName = self.monthFromAry((row % monthCount));
        NSString *currentMonthName = [self currentMonthName];
        if([monthName isEqualToString:currentMonthName] == YES)
        {
            selected = YES;
        }
    }
    else if(component == self.yearComponent)
    {
        NSInteger yearCount = self.years.count;
        NSString *yearName = self.yearFromAry(row % yearCount);
        NSString *currenrYearName  = [self currentYearName];
        if([yearName isEqualToString:currenrYearName] == YES)
        {
            selected = YES;
        }
    }
    else if(component == self.dayComponent)
    {
        //        NSLog(@"%@",[self nameOfDays]);
        NSInteger dayCount = self.days.count;
        NSString *dayName = self.dayFromAry((row % dayCount));
        NSString *currenrDayName  = [self currentDayName];
        if([dayName isEqualToString:currenrDayName] == YES)
        {
            selected = YES;
        }
    }
    else if(component == self.hourComponent)
    {
        //        NSLog(@"%@",[self nameOfDays]);
        NSInteger hourCount = self.hours.count;
        NSString *hourName = [self.hours safe_objectAtIndex:(row % hourCount)];
        NSString *currenrHourName  = [self currentHourName];
        if([hourName isEqualToString:currenrHourName] == YES)
        {
            selected = YES;
        }
    }
    else if(component == self.minComponent)
    {
        NSInteger minCount = self.mins.count;
        NSString *minName = [self.mins safe_objectAtIndex:(row % minCount)];
        NSString *currenrHourName  = [self currentMinName];
        if([minName isEqualToString:currenrHourName] == YES)
        {
            selected = YES;
        }

    }
    
    UILabel *returnView = nil;
    if(view.tag == LABEL_TAG)
    {
        returnView = (UILabel *)view;
    }
    else
    {
        returnView = [self labelForComponent:component];
    }
    
    returnView.font = selected ? [self selectedFontForComponent:component] : [self fontForComponent:component];
    returnView.textColor = selected ? [self selectedColorForComponent:component] : [self colorForComponent:component];
    
    returnView.text = [self titleForRow:row forComponent:component];
    
    return returnView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.rowHeight;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.numberOfComponent;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == self.monthComponent)
    {
        return self.months.count;
    }else if (component == self.yearComponent) {
        return self.years.count;
    }else if (component == self.dayComponent) {
        return self.days.count;
    }else if (component == self.hourComponent){
        return self.hours.count;
    }else if (component == self.minComponent){
        return self.mins.count;
    }
    return 0;
}

#pragma mark - Util

-(CGFloat)componentWidth
{
    return SCREEN_WIDTH / self.numberOfComponent - W(5);
}

-(NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == self.yearComponent) {
        return self.yearFromAry(row % self.years.count );
    } else if(component == self.monthComponent) {
        return self.monthFromAry((row % self.months.count));
    } else  if (component == self.dayComponent) {
        return self.dayFromAry((row % self.days.count));
    } else if (component == self.hourComponent){
        return [self.hours safe_objectAtIndex:(row % self.hours.count)];
    } else if (component == self.minComponent){
        return [self.mins safe_objectAtIndex:(row % self.mins.count)];
    }
    return @"";
}

-(UILabel *)labelForComponent:(NSInteger)component
{
    CGRect frame = CGRectMake(0, 0, [self componentWidth], self.rowHeight);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textAlignment = NSTextAlignmentCenter;    // UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = NO;
    
    label.tag = LABEL_TAG;
    
    return label;
}

-(NSArray *)nameOfMaxDays
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"d"];
    NSInteger DayMax = [formatter stringFromDate:self.maxDate].integerValue;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 1; i <= DayMax; i ++) {
        NSString *day = [NSString stringWithFormat:@"%d日",i];
        [tempArr addObject:day];
    }
    return tempArr;
}

-(NSArray *)nameOfMinDays
{
    [self.formatter setDateFormat:@"d"];
    
    NSUInteger numberOfDaysInMonth = [self daysCountWithSelDate];
    NSInteger DayMin = [self.formatter stringFromDate:self.minDate].integerValue;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = DayMin ; i <= numberOfDaysInMonth  ; i ++) {
        NSString *day = [NSString stringWithFormat:@"%ld日",(long)i];
        [tempArr addObject:day];
    }
    return tempArr;
}

-(NSArray *)nameOfMinMaxDays
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"d"];
    NSInteger DayMax = [formatter stringFromDate:self.maxDate].integerValue;
    
    NSInteger DayMin = [formatter stringFromDate:self.minDate].integerValue;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSInteger i = DayMin; i <= DayMax; i ++) {
        NSString *day = [NSString stringWithFormat:@"%ld日",(long)i];
        [tempArr addObject:day];
    }
    return tempArr;
}

-(NSArray *)nameOfDays
{
    NSUInteger numberOfDaysInMonth = [self daysCountWithSelDate];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 1; i < numberOfDaysInMonth +1 ; i ++) {
        NSString *day = [NSString stringWithFormat:@"%d日",i];
        [tempArr addObject:day];
    }
    return tempArr;
}

-(NSInteger)daysCountWithSelDate {
    self.calendar = [NSCalendar currentCalendar];

    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[self monthDate]];
    return range.length;
}


-(NSArray *)nameOfMinMonths {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"M"];
    NSInteger monthMin = [formatter stringFromDate:self.minDate].integerValue;
    NSMutableArray *months = [NSMutableArray array];
    
    for(NSInteger month = monthMin; month <= 12; month++)
    {
        NSString *monthStr = [NSString stringWithFormat:@"%li月", (long)month];
        [months addObject:monthStr];
    }
    return months;
}

-(NSArray *)nameOfMaxMonths {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"M"];
    NSInteger monthMax = [formatter stringFromDate:self.maxDate].integerValue;
    
    NSMutableArray *months = [NSMutableArray array];
    
    for(NSInteger month = 1; month <= monthMax; month++)
    {
        NSString *monthStr = [NSString stringWithFormat:@"%li月", (long)month];
        [months addObject:monthStr];
    }
    return months;
}

-(NSArray *)nameOfMaxAndMinMonths {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"M"];
    NSInteger monthMin = [formatter stringFromDate:self.minDate].integerValue;
    NSInteger monthMax = [formatter stringFromDate:self.maxDate].integerValue;
    
    NSMutableArray *months = [NSMutableArray array];
    
    for(NSInteger month = monthMin; month <= monthMax; month++)
    {
        NSString *monthStr = [NSString stringWithFormat:@"%li月", (long)month];
        [months addObject:monthStr];
    }
    return months;
}

-(NSArray *)nameOfMonths
{
    return @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
}

-(NSArray *)nameOfYears
{
    NSMutableArray *years = [NSMutableArray array];
    
    for(NSInteger year = self.minYear; year <= self.maxYear; year++)
    {
        NSString *yearStr = [NSString stringWithFormat:@"%li年", (long)year];
        [years addObject:yearStr];
    }
    return years;
}

-(NSArray *)nameOfHours
{
    NSMutableArray *hours = [NSMutableArray array];
    
    for(NSInteger hour = 0; hour <= 23; hour++)
    {
        NSString *hourStr = [NSString stringWithFormat:@"%li时", (long)hour];
        [hours addObject:hourStr];
    }
    return hours;
}

- (NSArray *)nameOfMins{
    NSMutableArray *mins = [NSMutableArray array];
    
    for(NSInteger min = 0; min < 60; min++)
    {
        NSString *minStr = [NSString stringWithFormat:@"%li分", (long)min];
        [mins addObject:minStr];
    }
    return mins;
}

-(NSArray *)nameOfMinHours
{
    NSMutableArray *hours = [NSMutableArray array];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H时"];
    NSInteger hourMin = [formatter stringFromDate:self.minDate].integerValue;
    for(NSInteger hour = hourMin; hour <= 23; hour++)
    {
        NSString *hourStr = [NSString stringWithFormat:@"%li时", (long)hour];
        [hours addObject:hourStr];
    }
    return hours;
}

-(NSArray *)nameOfMaxHours
{
    NSMutableArray *hours = [NSMutableArray array];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"M"];
    NSInteger hourMax = [formatter stringFromDate:self.maxDate].integerValue;
    for(NSInteger hour = 0; hour <= hourMax; hour++)
    {
        NSString *hourStr = [NSString stringWithFormat:@"%li时", (long)hour];
        [hours addObject:hourStr];
    }
    return hours;
}

-(NSString *)currentMonthName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"M月"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentYearName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentDayName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"d日"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentHourName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H时"];
    return [formatter stringFromDate:[NSDate date]];
}

-(NSString *)currentMinName
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"m分"];
    return [formatter stringFromDate:[NSDate date]];
}

- (UIColor *)selectedColorForComponent:(NSInteger)component
{
    return [UIColor blackColor];
}

- (UIColor *)colorForComponent:(NSInteger)component
{
    return [UIColor blackColor];
}

- (UIFont *)selectedFontForComponent:(NSInteger)component
{
    
    return [UIFont systemFontOfSize:F(18)];
}

- (UIFont *)fontForComponent:(NSInteger)component
{
    return [UIFont systemFontOfSize:F(18)];
}

-(void)loadDefaultsParameters
{
    self.rowHeight = 44;
    self.years = [self nameOfYears];
    self.months = [self nameOfMonths];
    self.days = [self nameOfDays];
    self.hours = [self nameOfHours];
    self.mins = [self nameOfMins];
    
    self.delegate = self;
    self.dataSource = self;
    [self selectDate:[NSDate date]];
    
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    

    if (component == self.yearComponent) {
        if ([self selectedRowInComponent:self.yearComponent] == 0 && self.years.count != 1) {
            self.months = [self nameOfMinMonths];
        } else if ([self selectedRowInComponent:self.yearComponent] == self.years.count - 1 && self.years.count != 1) {
            self.months = [self nameOfMaxMonths];
        }else if (self.years.count == 1){
            self.months = [self nameOfMaxAndMinMonths];
        } else {
            self.months = [self nameOfMonths];
        }
    }
    if (self.monthComponent != -1) {
        self.months = [self nameOfMonths];
        [pickerView reloadComponent:self.monthComponent];
    }
    if (self.dayComponent != -1) {
        self.days = [self nameOfDays];
        [pickerView reloadComponent:self.dayComponent];
    }
    
}

- (NSInteger )indexOfStr:(NSString *)str inAry:(NSArray *)ary{
    for (NSString * strItem in ary) {
        if ([strItem isEqualToString:str]) {
            return [ary indexOfObject:strItem];
        }
    }
    return -1;
}

- (void)selectDate:(NSDate *)date{
    if (self.yearComponent != -1) {
        NSString * strYearName = [self selectYearName:date];
        NSInteger index = [self indexOfStr:strYearName inAry:self.years];
        if ( index != -1) {
            [self selectRow: index
                inComponent: self.yearComponent
                   animated: YES];
        }
    }
    if (self.monthComponent != -1) {
        NSString * strMonthName = [self selectMonthName:date];
        NSInteger index = [self indexOfStr:strMonthName inAry:self.months];
        if ( index != -1) {
            [self selectRow: index
                inComponent: self.monthComponent
                   animated: YES];
        }
    }
    if (self.dayComponent != -1) {
        NSString * strDayName = [self selectDayName:date];
        NSInteger index = [self indexOfStr:strDayName inAry:self.days];
        if ( index != -1) {
            [self selectRow: index
                inComponent: self.dayComponent
                   animated: YES];
        }
    }
    if (self.hourComponent != -1) {
        NSString * strHourName = [self selectHourName:date];
        NSInteger index = [self indexOfStr:strHourName inAry:self.hours];
        if ( index != -1) {
            [self selectRow: index
                inComponent: self.hourComponent
                   animated: YES];
        }
    }
    if (self.minComponent != -1) {
        NSString * strMinName = [self selectMinName:date];
        NSInteger index = [self indexOfStr:strMinName inAry:self.mins];
        if (index != -1) {
            [self selectRow: index
                inComponent: self.minComponent
                   animated: YES];
        }
    }
}



-(NSString *)selectMonthName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setLocale:usLocale];
    [formatter setDateFormat:@"M月"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectYearName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy年"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectDayName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"d日"];
    return [formatter stringFromDate:date];
}

-(NSString *)selectHourName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"H时"];
    return [formatter stringFromDate:date];
}
-(NSString *)selectMinName:(NSDate *)date
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"m分"];
    return [formatter stringFromDate:date];
}

//-(NSIndexPath *)selectPathWithDate:(NSDate *)date // row - month ; section - year
//{
//    CGFloat row = 0.f;
//    CGFloat section = 0.f;
//    
//    NSString *month = [self selectMonthName:date];
//    NSString *year  = [self selectYearName:date];
//    
//    //set table on the middle
//    for(NSString *cellMonth in self.months)
//    {
//        if([cellMonth isEqualToString:month])
//        {
//            row = [self.months indexOfObject:cellMonth];
//            //            row = row + [self bigRowMonthCount] / 2;
//            break;
//        }
//    }
//    
//    for(NSString *cellYear in self.years)
//    {
//        if([cellYear isEqualToString:year])
//        {
//            section = [self.years indexOfObject:cellYear];
//            //            section = section + [self bigRowYearCount] / 2;
//            break;
//        }
//    }
//    
//    return [NSIndexPath indexPathForRow:row inSection:section];
//}

-(CGFloat)selectDayIndexWithDate:(NSDate *)date {// row - month ; section - year
    CGFloat index = 0.f;
    NSString *Day = [self selectDayName:date];
    for (NSString *cellDay in self.days)
    {
        if([cellDay isEqualToString:Day])
        {
            index = [self.days indexOfObject:cellDay];
            //            index = index + [self bigRowDaysCount] / 2;
            break;
        }
    }
    
    return index;
}

-(CGFloat)selectHourIndexWithDate:(NSDate *)date {// row - month ; section - year
    CGFloat index = 0.f;
    NSString *Hour = [self selectHourName:date];
    for (NSString *cellHour in self.hours)
    {
        if([cellHour isEqualToString:Hour])
        {
            index = [self.hours indexOfObject:cellHour];
            //            index = index + [self bigRowDaysCount] / 2;
            break;
        }
    }
    
    return index;
}

- (void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *minComps = [self.calendar components:unitFlags fromDate:minDate];
    self.minYear = [minComps year];//获取年对应的长整形字符串
}

- (void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *maxComps = [self.calendar components:unitFlags fromDate:maxDate];
    
    self.maxYear = [maxComps year];//获取年对应的长整形字符串
}

-(NSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [NSCalendar currentCalendar];
        
    }
    return _calendar;
}

-(NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setTimeZone:[NSTimeZone systemTimeZone]];
    }
    return _formatter;
}

- (NSDate *)extractDayDate:(NSDate *)date {
    //get seconds since 1970
    NSTimeInterval interval = [date timeIntervalSince1970] + 8 * 60 * 60;
    int daySeconds = 24 * 60 * 60;
    //calculate integer type of days
    NSInteger allDays = interval / daySeconds;
    
    return [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
}

- (NSDate *)extractHourDate:(NSDate *)date {
    //get seconds since 1970
    NSTimeInterval interval = [date timeIntervalSince1970];
    int daySeconds = 60 * 60;
    //calculate integer type of days
    NSInteger allDays = interval / daySeconds;
    if ((int)interval % daySeconds) {
        allDays ++;
    }
    return [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
}



@end
