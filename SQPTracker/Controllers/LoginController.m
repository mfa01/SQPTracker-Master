//
//  LoginController.m
//  SQPTracker
//
//  Created by MAbed on 3/1/16.
//  Copyright © 2016 mabed. All rights reserved.
//

#import "LoginController.h"
#import "WebHelper.h"
@implementation LoginController
-(void)viewDidLoad
{
    //this notification will run immediatly after user received access_token
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(goToProductsIfAuthorizaed:)
                                                 name:@"TokenNotification"
                                               object:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self initUserInterface];
}

-(void)viewDidAppear:(BOOL)animated
{
    //if user already authorized go to products
    //TODO check access token if expired
    [self goToProductsIfAuthorizaed:nil];
}
-(void)goToProductsIfAuthorizaed:(id)sender
{
    if([WebHelper getUserAccessToken])
    {
        [self performSegueWithIdentifier:@"GoToProducts" sender:nil];
    }
}
- (IBAction)connectToSouqAccount:(id)sender {
    [WebHelper authorizeUser];
}
- (IBAction)guest:(id)sender {
    
}


-(void)initUserInterface
{
    _btnConnectToSouqAccount.layer.cornerRadius=5;
    _btnGuest.layer.cornerRadius=_btnConnectToSouqAccount.layer.cornerRadius;
}
@end
