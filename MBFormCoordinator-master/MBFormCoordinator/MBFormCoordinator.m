
#import "MBFormCoordinator.h"
#import "NSObject+MBForm.h"
#import "NSString+MBForm.h"

@interface MBFormCoordinator () <UITextFieldDelegate, UITextViewDelegate>

@end

@implementation MBFormCoordinator
{
    NSArray *_textFields;
}

+ (instancetype)newWithDelegate:(id<MBFormDelegate>)delegate
{
    MBFormCoordinator *chainer = [MBFormCoordinator new];
    chainer.delegate = delegate;
    return chainer;
}

- (void)enumerateFields:(void(^)(id field, NSString *text, MBFieldValidationType type))block
{
    for(id field in _textFields) {
        block(field, [field text], [self validationTypeForField:field]);
    }
}

- (void)populateTextFieldsWithValues:(NSArray*)values
{
    [_textFields enumerateObjectsUsingBlock:^(UITextField *textField, NSUInteger idx, BOOL *stop) {
        textField.text = values[idx];
    }];
}

- (id)uniqueFieldForValidationType:(MBFieldValidationType)type
{
    NSMutableArray *fields = [NSMutableArray new];
    for(UITextField *textField in _textFields) {
        if([self validationTypeForField:textField] == type) {
            [fields addObject:textField];
        }
    }
    
    return fields.count == 1 ? fields.lastObject : nil;
}

- (NSString*)valueForFieldWithType:(MBFieldValidationType)type
{
    return [[self uniqueFieldForValidationType:type] text];
}

static NSString *OrderKey = @"MBTextFieldChainerOrderKey";
static NSString *ErrorKey = @"MBTextFieldChainerErrorKey";
static NSString *ValidationTypeKey = @"MBTextFieldChainerValidationTypeKey";

- (void)chainFields:(NSArray*)textFields finishType:(UIReturnKeyType)type
{
    [textFields enumerateObjectsUsingBlock:^(UITextField *field, NSUInteger index, BOOL *stop) {
        [field setDynamicValue:@(index) forKey:OrderKey associationPolicy:OBJC_ASSOCIATION_RETAIN];
        if(index == textFields.count - 1) {
            [field setReturnKeyType:type];
        } else {
            [field setReturnKeyType:UIReturnKeyNext];
        }
        field.delegate = self;
        if([_delegate respondsToSelector:@selector(validationTypeForField:atIndex:)]) {
            MBFieldValidationType validationType = [self.delegate validationTypeForField:field atIndex:index];
            [field setDynamicValue:@(validationType) forKey:ValidationTypeKey associationPolicy:OBJC_ASSOCIATION_RETAIN];
            if([_delegate respondsToSelector:@selector(validationErrorForField:validatonType:atIndex:)]) {
                MBValidationError *error = [self.delegate validationErrorForField:field
                                                                    validatonType:validationType
                                                                          atIndex:index];
                [field setDynamicValue:error forKey:ErrorKey associationPolicy:OBJC_ASSOCIATION_RETAIN];
            }
        }
        
        if([field isKindOfClass:[UITextField class]])
            [field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    }];
    _textFields = textFields;
}
static NSString *KeyPathKey = @"MBFieldCoordinatorKeyPathKey";
static NSString *ObjectKey = @"MBFieldCoordinatorObjectKey";

- (void)bindKeyPath:(NSString*)keypath ofObject:(id)object toField:(id)field
{
    [field setDynamicValue:keypath forKey:KeyPathKey associationPolicy:OBJC_ASSOCIATION_ASSIGN];
    [field setDynamicValue:object forKey:ObjectKey associationPolicy:OBJC_ASSOCIATION_RETAIN];
}

- (void)updateBindRelationshipForField:(id)field
{
    id bindedObject = [field getDynamicValueForKey:ObjectKey];
    id bindedKeyPath = [field getDynamicValueForKey:KeyPathKey];
    [bindedObject setValue:[field text] forKeyPath:bindedKeyPath];
}

- (void)advanceToFieldAfterField:(id)field
{
    NSInteger nextIndex = [[field getDynamicValueForKey:OrderKey] integerValue] + 1;
    if(nextIndex < _textFields.count) {
        id nextField = _textFields[nextIndex];
        [nextField becomeFirstResponder];
    }
    else {
        [field resignFirstResponder];
        [self completeForm];
    }
}

- (void)completeForm
{
    [_delegate formDidComplete:self];
}

- (MBValidationError*)errorForTextField:(UITextField*)textField
{
    return [textField getDynamicValueForKey:ErrorKey];
}

- (MBFieldValidationType)validationTypeForField:(UITextField*)textField
{
    return [[textField getDynamicValueForKey:ValidationTypeKey] integerValue];
}

- (BOOL)isFieldRequired:(id)field
{
    if([_delegate respondsToSelector:@selector(fieldRequired:atIndex:validationType:)])
        return [_delegate fieldRequired:field atIndex:[_textFields indexOfObject:field]
                           validationType:[self validationTypeForField:field]];
    return NO;
}

- (BOOL)validateTextField:(UITextField*)textField notifyDelegate:(BOOL)notify
{
    NSString *text = textField.text;
    NSInteger index = [_textFields indexOfObject:textField];
    BOOL didFail = NO;
    MBFieldValidationType type = [self validationTypeForField:textField];
    switch (type)
    {
        case MBFieldValidationTypeEmail:
            if(text.length && [text isValidEmail] == NO)
                didFail = YES;
            break;
            
        case MBFieldValidationTypeEmailConfirmation: {
            UITextField *emailTextField = [self uniqueFieldForValidationType:MBFieldValidationTypeEmail];
            if([emailTextField.text isEqualToString:textField.text] == NO)
                didFail = YES;
            break;
        }
        
        case MBFieldValidationTypeLetters:
        case MBFieldValidationTypeLastName:
        case MBFieldValidationTypeName:
            if([text containsOnlyLetters] == NO)
                didFail = YES;
            break;
        
        case MBFieldValidationTypeNumbers:
            if([text containsOnlyNumbers] == NO)
                didFail = YES;
            break;
            
        case MBFieldValidationTypeNumbersAndLetters:
            if([text containsOnlyNumbersAndLetters] == NO)
                didFail = YES;
            break;
            
        case MBFieldValidationTypeNone:
            break;
    }
    
    if(!didFail && text.length == 0) {
        if([_delegate respondsToSelector:@selector(fieldRequired:atIndex:validationType:)])
            didFail = [_delegate fieldRequired:textField atIndex:index validationType:type];
    }
   
    if(didFail) {
        if(notify) {
            [self resignAllFields];
            if([_delegate respondsToSelector:@selector(validationDidFailForField:atIndex:withError:)])
                [self.delegate validationDidFailForField:textField
                                                 atIndex:index
                                               withError:[self errorForTextField:textField]];
        }
        return NO;
    }
    return YES;
}

- (void)resignAllFields
{
    for(UITextField *field in _textFields) {
        if(field.isFirstResponder)
           [field resignFirstResponder];
    }
}

- (BOOL)validateAllFieldsWithInvalidBlock:(MBValidationBlock)invalidBlock
{
    __block NSMutableArray *invalidFields = [NSMutableArray new];
    __block NSMutableArray *invalidErrors = [NSMutableArray new];
    [_textFields enumerateObjectsUsingBlock:^(UITextField *field, NSUInteger index, BOOL *stop) {
        if(![self validateTextField:field notifyDelegate:NO]) {
            [invalidFields addObject:field];
            MBValidationError *error = [self errorForTextField:field];
            if(!error && [self isFieldRequired:field])
                error = [MBValidationError errorWithName:@"Missing field" details:@"A required field is not filled out."];
            [invalidErrors addObject:error];
        }
    }];
    
    if(invalidFields.count > 0) {
        invalidBlock(invalidFields, invalidErrors);
        return NO;
    }
    return YES;
}

#pragma mark - UITextField Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
        [_delegate textFieldDidBeginEditing:textField];
}

- (void)textFieldDidChange:(UITextField*)textField
{
    [self updateBindRelationshipForField:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldDidEndEditing:)])
        [_delegate textFieldDidEndEditing:textField];

    [self advanceToFieldAfterField:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([_delegate respondsToSelector:@selector(textFieldShouldReturn:)])
        [_delegate textFieldShouldReturn:textField];
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
        return [_delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return YES;
}

#pragma mark - UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateBindRelationshipForField:textView];
    if([_delegate respondsToSelector:@selector(textViewDidChange:)])
        [_delegate textViewDidChange:textView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([_delegate respondsToSelector:@selector(textViewDidBeginEditing:)])
        [_delegate textViewDidBeginEditing:textView];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if([_delegate respondsToSelector:@selector(textViewDidEndEditing:)])
        [_delegate textViewDidEndEditing:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if([_delegate respondsToSelector:@selector(textViewDidChangeSelection:)])
        [_delegate textViewDidChangeSelection:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"] && textView.returnKeyType != UIReturnKeyDefault) {
        [self advanceToFieldAfterField:textView];
        return NO;
    }
    if([_delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
        return [_delegate textView:textView shouldChangeTextInRange:range replacementText:text];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
        return [_delegate textViewShouldBeginEditing:textView];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if([_delegate respondsToSelector:@selector(textViewShouldEndEditing:)])
        return [_delegate textViewShouldEndEditing:textView];
    return YES;
}

@end

@implementation MBValidationError

+ (instancetype)errorWithName:(NSString*)name details:(NSString*)desc
{
    MBValidationError * error = [MBValidationError new];
    error.name = name;
    error.details = desc;
    return error;
}

+ (instancetype)errorByAppendingErrors:(NSArray*)errors withTitleSeparator:(NSString*)titleSep detailsSeparator:(NSString*)descSep
{
    NSMutableString *name = [NSMutableString new];
    NSMutableString *desc = [NSMutableString new];
    [errors enumerateObjectsUsingBlock:^(MBValidationError *error, NSUInteger index, BOOL *stop) {
        if(index != 0) {
            [name appendString:titleSep];
            [desc appendString:descSep];
        }
        [name appendString:error.name];
        [desc appendString:error.details];
    }];
    return [MBValidationError errorWithName:name details:desc];
}

@end
