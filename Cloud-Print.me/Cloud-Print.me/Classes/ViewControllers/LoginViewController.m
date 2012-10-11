//
//  LoginViewController.m
//  Cloud-Print.me
//
//  Created by Vadim Osovets on 09.10.12.
//  Copyright (c) 2012 Vadim Osovets. All rights reserved.
//

#import "LoginViewController.h"
#import "APIClient.h"

@implementation LoginViewController {
    
    __weak IBOutlet UITextField *_emailTextField;
    __weak IBOutlet UITextField *_passwordTextField;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DefaultBackground.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _emailTextField = nil;
    _passwordTextField = nil;
    [super viewDidUnload];
}

#pragma mark - Callbacks

- (IBAction)loginClicked:(id)sender {
    
    if ([_emailTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Ошибка:" message:@"Поле \"email\" не может быть пустым" delegate:nil cancelButtonTitle:@"Да" otherButtonTitles: nil] show];
        return;
    }

    if ([_passwordTextField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"Ошибка:" message:@"Поле \"пароль\" не может быть пустым" delegate:nil cancelButtonTitle:@"Да" otherButtonTitles: nil] show];
        return;
    }
    
    [[APIClient sharedClient] loginWithEmail:_emailTextField.text
                                    password:_passwordTextField.text
                                 withSuccess:^(NSDictionary *response) {
        [self dismissModalViewControllerAnimated:YES];
    } failure:^(NSError *error) {

    }];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:_emailTextField]) {
        [_passwordTextField becomeFirstResponder];
    } else {
        [_passwordTextField resignFirstResponder];
    }
    
    return YES;
}

@end
