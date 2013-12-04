//
//  DetailViewController.m
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 28/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (retain) NSArray * days;
@end

@implementation DetailViewController
@synthesize imageView, days;
@synthesize details;
@synthesize imageName;
@synthesize address,phone, openingHours;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        days = [[NSArray alloc] initWithObjects:@"Mon:",@"Tue: ",@"Wed:",@"Thu:",@"Fri:  ",@"Sat: ",@"Sun:",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imageView.image = [UIImage	imageNamed:imageName];
    [address sizeToFit];
    address.numberOfLines = 0;
    [phone sizeToFit];
    phone.numberOfLines = 0;
    [openingHours sizeToFit];
    NSString * addressStr = [[details objectForKey:@"Address"] stringByReplacingOccurrencesOfString:@", " withString:@"\n"];
    addressStr = [addressStr stringByAppendingString:@"\n"];
    addressStr = [addressStr stringByAppendingString:[details objectForKey:@"Postcode"]];
    address.text = addressStr;

    NSString * phoneNo = [details objectForKey:@"Phone"];
    if (phoneNo != (id)[NSNull null]) {
        phone.text = phoneNo;
    }
    NSMutableString * oh = [[NSMutableString alloc] init];
    NSInteger index = 0;
    for(NSString * str in [details objectForKey:@"OpeningHours"])
    {
        [oh appendFormat:@"%@\t%@\n",days[index++],str];
    }
    openingHours.text = oh;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
