//
//  ScheduleConfirmView.h


#import <UIKit/UIKit.h>

@interface ScheduleConfirmView : UIView

@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *ivClose;
@property (nonatomic, strong) UIImageView *ivDown;
@property (nonatomic, strong) UIImageView *ivDown1;

@property (nonatomic, strong) UIView *viewNameBorder;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UIView *viewBorder;
@property (nonatomic, strong) UILabel *labelCarNumber;
@property (nonatomic, strong) UIView *viewPhoneBorder;
@property (nonatomic, strong) UITextField *tfPhone;
@property (nonatomic, strong) UITextField *tfReceiveCompanyName;
@property (nonatomic, strong) UITextField *tfAddressDetail;
@property (nonatomic, strong) UITextField *tfReceiverName;
@property (nonatomic, strong) UITextField *tfReceiverPhone;
@property (nonatomic, strong) UILabel *labelReceiveAddress;
@property (nonatomic, strong) UIView *viewReceiveCompanyNameBorder;
@property (nonatomic, strong) UIView *viewAddressDetailBorder;
@property (nonatomic, strong) UIView *viewReceiverNameBorder;
@property (nonatomic, strong) UIView *viewReceiverPhoneBorder;
@property (nonatomic, strong) UIView *viewReceiveAddressBorder;

@property (nonatomic, strong) UIButton *btnSubmit;
@property (nonatomic, strong) void (^blockComplete)(ModelValidCar *model,NSString*phone);
@property (nonatomic, strong) void (^blockAllComplete)(ModelValidCar *model,NSString*phone,NSString *companyName,double addressId,NSString *addressDetail,NSString *receiverName,NSString *receiverPhone);

@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) ModelProvince *modelProvince;
@property (nonatomic, strong) ModelProvince *modelCity;
@property (nonatomic, strong) ModelProvince *modelDistrict;


#pragma mark 刷新view
- (void)resetViewWithModel:(BOOL)showAll;
- (void)show;

@end

