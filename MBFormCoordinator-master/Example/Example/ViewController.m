
//  Created by Mo Bitar on 8/16/13.

#import "ViewController.h"
#import "MBFormCoordinator.h"
#import "User.h"

@interface ViewController () <MBFormDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *confirmEmailField;
@property (weak, nonatomic) IBOutlet UITextView *bioField;
@property (nonatomic) User *user;
@end

@implementation ViewController
{
    MBFormCoordinator *_form;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureUser];
    [self configureForm];
}

- (void)configureUser
{
    _user = [User new];
}

- (void)configureForm
{
    _form = [MBFormCoordinator newWithDelegate:self];
    [_form chainFields:@[_firstNameField, _lastNameField, _emailField, _confirmEmailField, _bioField] finishType:UIReturnKeyJoin];
    [_form bindKeyPath:@"firstName" ofObject:_user toField:_firstNameField];
    [_form bindKeyPath:@"lastName" ofObject:_user toField:_lastNameField];
    [_form bindKeyPath:@"email" ofObject:_user toField:_emailField];
    [_form bindKeyPath:@"bio" ofObject:_user toField:_bioField];
}

#pragma mark - Form Delegate

- (MBFieldValidationType)validationTypeForField:(id)field atIndex:(NSUInteger)index
{
    switch (index) {
        case 0: return MBFieldValidationTypeName;
        case 1: return MBFieldValidationTypeLastName;
        case 2: return MBFieldValidationTypeEmail;
        case 3: return MBFieldValidationTypeEmailConfirmation;
        default: return MBFieldValidationTypeNone;
    }
}

- (MBValidationError*)validationErrorForField:(id)field validatonType:(MBFieldValidationType)type atIndex:(NSUInteger)index
{
    switch (index) {
        case 0: return [MBValidationError errorWithName:@"Invalid name" details:@"Please make sure you enter a valid name."];
        case 1: return [MBValidationError errorWithName:@"Invalid name" details:@"Please make sure you enter a valid last name."];
        case 2: return [MBValidationError errorWithName:@"Invalid name" details:@"Please make sure you enter a valid email."];
        case 3: return [MBValidationError errorWithName:@"Invalid name" details:@"The emails you entered did not match"];
        default: return nil;
    }
}

- (void)validationDidFailForField:(id)field atIndex:(NSUInteger)index withError:(MBValidationError *)error
{
    [[[UIAlertView alloc] initWithTitle:error.name message:error.details
     delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)formDidComplete:(MBFormCoordinator *)form
{
    NSString *message = [NSString stringWithFormat:@"Your application has been submitted:\nFirst name: %@\nLast name: %@\nEmail: %@\nBio: %@",
                         _user.firstName, _user.lastName, _user.email, _user.bio];
    [[[UIAlertView alloc] initWithTitle:@"Success" message:message
     delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

@end
