//
//  ViewController.m
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 25/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import "MainViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tbPostcode, btnGP, btnMIU, btnDentist,btnPharmacy,btnOptician,btnED;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self postcodeTextChanged:nil];
	// Do any additional setup after loading the view, typically from a nib.
//    [btnGP setEnabled:NO];
//    [btnGP setEnabled:NO];
//    [btnMIU setEnabled:NO];
//    [btnPharmacy setEnabled:NO];
//    [btnOptician setEnabled:NO];
//    [btnDentist setEnabled:NO];
//    [btnED setEnabled:NO];
    

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar.png"]];

//    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x7377c4)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showResults"]) {
        [self.view endEditing:YES];
        ResultsTableViewController * resultsController = (ResultsTableViewController *)segue.destinationViewController;
        [resultsController setPageTitle:resultsTitle];
        [resultsController setPostcode:self.tbPostcode.text];
        resultsController.serviceId = serviceId;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
//    if([identifier isEqualToString:@"showResults"]) {
        if(postcodeMsg.length > 0)
        {
            return NO;
        }
        return YES;
//    }
//    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)btnClicked:(id)sender {
    if(postcodeMsg.length > 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Invalid Postcode" message:postcodeMsg delegate: nil cancelButtonTitle : @"Close" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if((UIButton *)sender == btnGP) {
        resultsTitle  = @"Surgeries";
        serviceId = @"/1/";
    } else if((UIButton *)sender == btnMIU) {
        resultsTitle  = @"Minor Injury Units";
        serviceId = @"/2/";
    } else     if((UIButton *)sender == btnPharmacy) {
        resultsTitle  = @"Pharmacies";
        serviceId = @"/3/";
    } else     if((UIButton *)sender == btnOptician) {
        resultsTitle  = @"Optician";
        serviceId = @"/4/";
    } else     if((UIButton *)sender == btnDentist) {
        resultsTitle  = @"Dentists";
        serviceId = @"/5/";
    } else     if((UIButton *)sender == btnED) {
        resultsTitle  = @"Hospitals A&E";
        serviceId = @"/6/";
    }
}


- (IBAction)postcodeTextChanged:(id)sender {
    NSString * postCode = [tbPostcode.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(postCode.length < 6) {
        postcodeMsg = @"Postcode length too short";
        return;
    }
    if([postCode stringByTrimmingCharactersInSet:[NSCharacterSet alphanumericCharacterSet]].length > 0) {
        postcodeMsg = @"Invalid characters in postcode.";
        return;
    }
    postcodeMsg = @"";
    
//    Boolean isEnabled = NO;
//    if(tbPostcode.text.length >= 6) {
//        isEnabled = YES;
//    }
//    [btnGP setEnabled:isEnabled];
//    [btnMIU setEnabled:isEnabled];
//    [btnPharmacy setEnabled:isEnabled];
//    [btnOptician setEnabled:isEnabled];
//    [btnDentist setEnabled:isEnabled];
//    [btnED setEnabled:isEnabled];
}
@end
