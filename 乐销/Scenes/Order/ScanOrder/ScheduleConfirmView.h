//
//  ScheduleConfirmView.h


#import <UIKit/UIKit.h>

@interface ScheduleConfirmView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIView *viewNameBorder;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIView *viewBorder;
@property (nonatomic, strong) UILabel *labelCarNumber;
@property (nonatomic, strong) UIView *viewPhoneBorder;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(ModelValidCar *model,NSString*phone);
@property (nonatomic, strong) NSMutableArray *aryDatas;


#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;
- (void)show;

@end

