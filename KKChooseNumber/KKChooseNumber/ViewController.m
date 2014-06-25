//
//  ViewController.m
//  KKChooseNumber
//
//  Created by Thanh Tran on 6/23/14.
//  Copyright (c) 2014 ThanhTran. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    NSString *countryCode;
    NSUInteger numCount;
    UITapGestureRecognizer *tapToDimissKB;
    
    
    
    
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.phoneUtil = [NBPhoneNumberUtil sharedInstance];
    
    tapToDimissKB = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKB:)];
    [self.countryPicker setSelectedCountryCode:@"VN"];
    [self countryPicker:self.countryPicker didSelectCountryWithName:@"Viet Nam" code:@"VN"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    self.lblCountryName.text = name;
    countryCode = code;
    NSString *cCode = [self.phoneUtil countryCodeFromRegionCode:code];
    self.txtZone.text = [NSString stringWithFormat:@"+%@",cCode];
    self.exampleNumber = [self.phoneUtil getExampleNumber:code error:nil];
    
    NSString *placeHolderNumber = [self.phoneUtil format:self.exampleNumber
                                                numberFormat:NBEPhoneNumberFormatE164
                                                   error:nil];
    placeHolderNumber = [placeHolderNumber stringByReplacingOccurrencesOfString:self.txtZone.text withString:@""];
    numCount = [placeHolderNumber length];
    self.txtPhoneNumbe.placeholder = placeHolderNumber;
    [self.scrollView setContentSize:CGSizeMake(320.0f, 568.0f)];
    
    [self.txtPhoneNumbe resignFirstResponder];
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
        
    }];
    
    
}

- (IBAction)goTapped:(id)sender {

    if ([self checkPhoneNumber]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"KK Phone" message:@"Number is Correct" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }else {
    
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"KK Phone" message:@"Number is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    
}

-(BOOL)checkPhoneNumber{
    
    BOOL isValid = NO;
    NSString *myNumberString = self.txtPhoneNumbe.text;
    NBPhoneNumber *myNumber = [self.phoneUtil parse:myNumberString
                                 defaultRegion:countryCode error:nil];
    
    isValid = [self.phoneUtil isValidNumber:myNumber];
    
    NSLog(@"num count %d -- leng %d",numCount, [myNumberString length]);
    if ([myNumberString length] == numCount) {
    
        return YES;
    }else {
        return NO;
    }

}
-(void)hideKB:(UITapGestureRecognizer *)gesture{
    [self.scrollView setContentSize:CGSizeMake(320.0f, self.scrollView.frame.size.height - 50.0f)];
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f)];
    }];
    
    [self.txtPhoneNumbe resignFirstResponder];
    
//    [self.scrollView removeGestureRecognizer:tapToDimissKB];
}

#pragma mark - Textfield
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    [self.scrollView setContentSize:CGSizeMake(320.0f, self.scrollView.frame.size.height + 80.0f)];
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollView setContentOffset:CGPointMake(0.0f, 80.0f)];
    }];
    
//    [self.scrollView addGestureRecognizer:tapToDimissKB];
    

    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([self checkPhoneNumber]) {
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"KK Phone" message:@"Number is Correct" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }else {
        
        UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"KK Phone" message:@"Number is incorrect" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [al show];
    }
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /* for backspace */
    if([string length]==0){
        return YES;
    }
    
    /*  limit to only numeric characters  */
    
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if ([myCharSet characterIsMember:c]) {
            return YES;
        }
    }
    
    return NO;
}

@end
