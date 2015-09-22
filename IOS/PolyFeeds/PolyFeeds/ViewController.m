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


- (IBAction)SignInButton:(id)sender {
    
    NSLog(@"Press SignIn");
    
    NSString ID = [[self.IdTextField text]floatValue];
    NSString PassWord = [[self.PassWordTextField text]floatValue];

    
//    if ([IdText  isEqual: @"admin"]){
//        NSLog(@"PassWord OK !");
//    }
    
}
@end
