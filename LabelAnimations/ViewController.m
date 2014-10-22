//
//  ViewController.m
//  LabelAnimations
//
//  Created by Dan Hogan on 10/20/14.
//  Copyright (c) 2014 Dan Hogan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray *labels;
@property (nonatomic) NSMutableArray *labelWidths;
@property (nonatomic) NSArray *strings;
@property (nonatomic) NSArray *colors;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];

    self.labels = [NSMutableArray new];
    self.labelWidths = [NSMutableArray new];

    self.strings = @[@" Hello ",
                     @" It's all ball bearings these days ",
                     @" Maybe you need ",
                     @" A refresher course ",
                     @" Moon River ",
                     @" I'll have a steak sandwich ",
                     @" And a steak sandwich ",
                     @" John Coctostone ",
                     @" Ted Nugent ",
                     @" 5-9, 6-2 with the afro ",
                     @" So I've got that going for me ",
                     @" Tears in his eyes I guess "];

    self.colors = @[[UIColor colorWithRed:0.89 green:0.09 blue:0.22 alpha:1],
                     [UIColor colorWithRed:0.83 green:0.1 blue:0.25 alpha:1],
                     [UIColor colorWithRed:0.78 green:0.1 blue:0.31 alpha:1],
                     [UIColor colorWithRed:0.71 green:0.11 blue:0.35 alpha:1],
                     [UIColor colorWithRed:0.65 green:0.11 blue:0.39 alpha:1],
                     [UIColor colorWithRed:0.59 green:0.11 blue:0.44 alpha:1],
                     [UIColor colorWithRed:0.53 green:0.12 blue:0.48 alpha:1],
                     [UIColor colorWithRed:0.50 green:0.12 blue:0.52 alpha:1],
                     [UIColor colorWithRed:0.47 green:0.12 blue:0.55 alpha:1],
                     [UIColor colorWithRed:0.43 green:0.12 blue:0.59 alpha:1],
                     [UIColor colorWithRed:0.40 green:0.13 blue:0.63 alpha:1],
                     [UIColor colorWithRed:0.37 green:0.13 blue:0.67 alpha:1],
                     ];

    for (int i = 1; i < 13; i++) {
        CGRect frame = CGRectMake (12, 50 + i * 26, 200.0, 20.0);
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        if (i == 1) {
            label.textColor = [UIColor whiteColor];
        } else {
            label.textColor = [UIColor colorWithRed:0.13 green:0.13 blue:0.13 alpha:1];
        }

        label.font = [UIFont fontWithName:@"AvenirNext-Bold" size:16];
        label.text = [[self.strings objectAtIndex:(i - 1)] uppercaseString];
        label.backgroundColor = [self.colors objectAtIndex:(i - 1)];
        label.contentMode = UIViewContentModeLeft;
        [self.view addSubview:label];
        [self.labels addObject:label];
    }

    for (UILabel *label in self.labels) {
        label.contentMode = UIViewContentModeScaleToFill;
        CGFloat labelWidth = label.frame.size.width;
        NSNumber *labelWidthNumber = [NSNumber numberWithFloat:labelWidth];
        NSMutableDictionary *dict = [NSMutableDictionary new];
        [dict setObject:labelWidthNumber forKey:@"indexOfObject"];

        [self.labelWidths addObject:dict];

    }

    [self presentLabelAnimated:YES];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentLabelAnimated:)];
    [self.view addGestureRecognizer:tap];
}

-(void)prepareForAnimation
{
    for (UILabel *label in self.labels) {
        [label.layer removeAllAnimations];
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, 107, label.frame.size.height);
        label.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
    }
}

-(void)presentLabelAnimated:(BOOL)animated
{

    [self prepareForAnimation];

    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = [self.labels objectAtIndex:i];
        label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y - 10.25, self.view.frame.size.width - 8 - 16 - 8, label.frame.size.height);
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             label.layer.transform = CATransform3DIdentity;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.25
                                                   delay:0.15 + i * 0.01
                                                 options:UIViewAnimationOptionCurveEaseOut
                                              animations:^{
                                                  [label sizeToFit];
                                              }
                                              completion:nil];
                         }];
    }
}

@end
