//
//  ViewController.h
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 25/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewController.h"

@interface MainViewController : UIViewController {
    NSString * resultsTitle;
    NSString * serviceId;
    NSString * postcodeMsg;
}
@property (weak, nonatomic) IBOutlet UITextField *tbPostcode;
- (IBAction)btnClicked:(id)sender;
- (IBAction)postcodeTextChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMIU;
@property (weak, nonatomic) IBOutlet UIButton *btnOptician;
@property (weak, nonatomic) IBOutlet UIButton *btnDentist;
@property (weak, nonatomic) IBOutlet UIButton *btnED;
@property (weak, nonatomic) IBOutlet UIButton *btnPharmacy;
@property (weak, nonatomic) IBOutlet UIButton *btnGP;
@end
