//
//  ViewController.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "ViewController.h"
#import "ConfigVars.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(showLoginView) withObject:nil afterDelay:Logo_Seconds];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)showLoginView
{
    [self performSegueWithIdentifier:@"GoToLoginController" sender:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
