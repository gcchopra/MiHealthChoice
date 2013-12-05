//
//  DetailViewController.h
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 28/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewDetails;
@property (weak, nonatomic) IBOutlet UITextView *textViewName;
@property (weak, nonatomic) IBOutlet UITextView *textViewAddress;
@property (nonatomic, strong) NSDictionary * details;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) NSString * imageName;
@end
