//
//  ResultsTableViewController.h
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 26/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsTableViewController : UITableViewController<NSURLConnectionDelegate,UIAlertViewDelegate> {
    NSMutableData * _results;
    NSString * postCode;
    NSString * pageTitle;
    NSString * serviceId;
    NSMutableArray * serviceData;
    UIActivityIndicatorView *activityIndicatorView;
}

//@property (nonatomic,retain) NSMutableArray * results;
@property (nonatomic, strong) NSString *serviceId;
-(void) setPostcode:(NSString *)postCode;
-(void) setPageTitle:(NSString *)title;
-(UIActivityIndicatorView *) showActivityIndicatorOnView:(UIView*)aView;
@end
