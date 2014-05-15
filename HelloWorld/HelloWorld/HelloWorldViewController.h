//
//  HelloWorldViewController.h
//  HelloWorld
//
//  Created by 野田 潤平 on 2014/05/02.
//  Copyright (c) 2014年 jp.co.jnp.nd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController
<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField_2;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userName_last;

- (IBAction)changeGreeting:(id)sender;
- (IBAction)deleteGreeting:(id)sender;


@end
