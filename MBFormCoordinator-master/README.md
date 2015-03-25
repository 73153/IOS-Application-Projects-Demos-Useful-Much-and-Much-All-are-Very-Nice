##MBFormCoordinator

Easily chain, bind, and validate text fields.

Every app I've ever created has always had a form of some sort. And in every app, I've found myself always recreating the same basic components: 

- chaining fields so that a user can advance from one to the other
- validating values of fields 
- associating the text of a field to a model property. 

This library does this for you, so you don't have to reinvent the wheel everytime.

##Features
####Chain text fields:
```objective-c
MBFormCoordinator *form = [MBFormCoordinator newWithDelegate:self];
[form chainFields:@[_firstNameField, _emailField, _confirmEmailField] finishType:UIReturnKeyJoin];
```

####Bind field values to a model
```objective-c
[form bindKeyPath:@"firstName" ofObject:_user toField:_firstNameField];
[form bindKeyPath:@"email" ofObject:_user toField:_emailField];
```

####Validate fields
`MBFormCoordinator` handles field validation. Just implement the following delegate methods:

```objective-c
- (MBFieldValidationType)validationTypeForField:(id)field atIndex:(NSUInteger)index
{
    switch (index) {
        case 0: return MBFieldValidationTypeName;
        case 1: return MBFieldValidationTypeEmail;
        case 2: return MBFieldValidationTypeEmailConfirmation;
        default: return MBFieldValidationTypeNone;
    }
}

- (MBValidationError*)validationErrorForField:(id)field validatonType:(MBFieldValidationType)type atIndex:(NSUInteger)index
{
	  return [MBValidationError errorWithName:@"Invalid value" details:@"You've entered an invalid value for one of the fields"];
}

- (void)validationDidFailForField:(id)field atIndex:(NSUInteger)index withError:(MBValidationError *)error
{
    [[[UIAlertView alloc] initWithTitle:error.name message:error.details
     delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)formDidComplete:(MBFormCoordinator *)form
{
	// handle form completion
}

```

##Important
`MBFormCoordinator` must be the delegate to all fields, so make sure you don't set the delegate property for your UITextField or UITextView. The form coordinator will however forward all `UITextField` and `UITextView` delegate callbacks to the form delegate.

