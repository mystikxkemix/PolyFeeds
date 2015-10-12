//
//  ViewController.m
//  PolyFeeds
//
//  Created by Gabin NIVERT on 24/09/2015.
//  Copyright (c) 2015 Gabin NIVERT. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    infodictionary = [NSDictionary dictionaryWithObject: [NSArray arrayWithObjects:@"password", nil] forKey:[NSArray arrayWithObjects:@"ID", nil]];
    
    _barButton.target = self.revealViewController;
    _barButton.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (IBAction)PassButton:(id)sender{
    if ([[infodictionary objectForKey:IDField.text] isEqualToString:PassWordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Correct Password" message:@"The password is correct" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        [self performSegueWithIdentifier:@"Button_SignIn" sender:self];
        
    } else {
        UIAlertView *alert2 = [[UIAlertView alloc]initWithTitle:@"Incorrect Password" message:@"The password is incorrect" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert2 show];
    }

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
