//
//  SetGameViewController.m
//  Games
//
//  Created by Robert Walker on 2/14/13.
//  Copyright (c) 2013 Robert Walker. All rights reserved.
//

#import "SetGameViewController.h"

@interface SetGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation SetGameViewController

- (IBAction)newDeal:(UIButton *)sender
{
}

- (IBAction)chooseCard:(UIButton *)sender
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


@end
