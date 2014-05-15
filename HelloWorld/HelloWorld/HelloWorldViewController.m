//
//  HelloWorldViewController.m
//  HelloWorld
//
//  Created by 野田 潤平 on 2014/05/02.
//  Copyright (c) 2014年 jp.co.jnp.nd. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController ()

@end

@implementation HelloWorldViewController

@synthesize userName = _userName;
@synthesize userName_last = _userName_last;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeGreeting:(id)sender {
    self.userName = self.textField.text;
    self.userName_last = self.textField_2.text;
    
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    NSString *nameString_last = self.userName_last;
    if ([nameString_last length] == 0) {
        nameString_last = @"End";
    }
    
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@ %@!", nameString, nameString_last];
    self.label.text = greeting;
}

- (IBAction)deleteGreeting:(id)sender {
    self.textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    if(theTextField == self.textField ||
       theTextField == self.textField_2) {
        [theTextField resignFirstResponder];
    }
    return YES;
}
@end
