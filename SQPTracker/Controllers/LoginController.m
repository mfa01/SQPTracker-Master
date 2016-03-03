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
-(void)viewWillAppear:(BOOL)animated
{
    [self initUserInterface];
    
    
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
