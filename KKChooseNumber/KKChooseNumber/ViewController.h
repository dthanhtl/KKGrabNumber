//
//  ViewController.h
//  KKChooseNumber
//
//  Created by Thanh Tran on 6/23/14.
//  Copyright (c) 2014 ThanhTran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"
#import "NBPhoneNumberUtil.h"

@interface ViewController : UIViewController <CountryPickerDelegate, UITextFieldDelegate>{


}
@property (strong, nonatomic) IBOutlet CountryPicker *countryPicker;
@property (strong, nonatomic) IBOutlet UILabel *lblCountryName;

@property (strong, nonatomic) NBPhoneNumber *outputNumber;
@property (strong, nonatomic) NBPhoneNumber *exampleNumber;

@property (strong, nonatomic) IBOutlet UITextField *txtZone;
@property (strong, nonatomic) NBPhoneNumberUtil *phoneUtil;
@property (strong, nonatomic) IBOutlet UITextField *txtPhoneNumbe;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
