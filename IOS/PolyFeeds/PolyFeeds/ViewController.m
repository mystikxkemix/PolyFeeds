//
//  ViewController.m
//  PolyFeeds
//
//  Created by Gabin NIVERT on 11/09/2015.
//  Copyright (c) 2015 Gabin NIVERT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *IDs;
NSString *Passs;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonSignIn:(UIButton *)sender {
    if([IDs  isEqual: @"admin"] && [Passs  isEqual: @"admin"]){
        NSLog(@"Access Succes");
    }
}

- (IBAction)ID:(UITextField *)IDField {
    IDs = (NSString*)IDField.text;
}

- (IBAction)PassWord:(UITextField *)PassField{
    Passs = (NSString*)PassField.text;
}
@end
