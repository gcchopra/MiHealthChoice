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
@synthesize imageName, textViewDetails,textViewAddress, textViewName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        days = [[NSArray alloc] initWithObjects:@"Mon:",@"Tue:",@"Wed:",@"Thu:",@"Fri:",@"Sat:",@"Sun:",nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bar.png"]];
    
    // Do any additional setup after loading the view from its nib.
    imageView.image = [UIImage	imageNamed:imageName];
    
    
    
    [textViewName sizeToFit];
    [textViewAddress sizeToFit];
    textViewName.text = [details objectForKey:@"Name"];
    NSMutableString * address = [[NSMutableString alloc] initWithString:[[details objectForKey:@"Address"] stringByReplacingOccurrencesOfString:@", " withString:@"\n"]];
    [address appendFormat:@"\n%@",[details objectForKey:@"Postcode"]];
    textViewAddress.text = address;
    NSMutableString * data = [[NSMutableString alloc] initWithFormat:@"Phone:  \t%@\n\n",[details objectForKey:@"Phone"]];
    [data appendString:@"Opening Hours:\n"];
    NSInteger index = 0;
    for(NSString * str in [details objectForKey:@"OpeningHours"])
    {
       [data appendFormat:@"    %@\t%@\n",days[index++],str];
    }
    textViewDetails.text = data;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
