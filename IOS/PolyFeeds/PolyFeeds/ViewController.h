//
//  ViewController.h
//  PolyFeeds
//
//  Created by Gabin NIVERT on 11/09/2015.
//  Copyright (c) 2015 Gabin NIVERT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *IdTextField;

@property (weak, nonatomic) IBOutlet UITextField *PassWordTextField;

- (IBAction)SignInButton:(id)sender;

@end

