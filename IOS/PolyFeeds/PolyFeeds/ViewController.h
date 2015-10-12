//
//  ViewController.h
//  PolyFeeds
//
//  Created by Gabin NIVERT on 24/09/2015.
//  Copyright (c) 2015 Gabin NIVERT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    IBOutlet UITextField *IDField;
    IBOutlet UITextField *PassWordField;
        
    NSDictionary *infodictionary;
    
}

- (IBAction)PassButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *ReglageButton;

@end

