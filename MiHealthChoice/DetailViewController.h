//
//  DetailViewController.h
//  MiDosServiceFinder
//
//  Created by Girish Chopra on 28/11/2013.
//  Copyright (c) 2013 Intuiti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary * details;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *openingHours;
@property (nonatomic, strong) NSString * imageName;
@end
