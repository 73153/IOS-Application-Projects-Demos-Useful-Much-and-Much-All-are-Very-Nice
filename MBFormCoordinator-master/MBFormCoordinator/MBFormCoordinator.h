#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MBFieldValidationType)
{
    MBFieldValidationTypeNone,
    MBFieldValidationTypeName,
    MBFieldValidationTypeLastName,
    MBFieldValidationTypeLetters,
    MBFieldValidationTypeNumbers,
    MBFieldValidationTypeNumbersAndLetters,
    MBFieldValidationTypeEmail,
    MBFieldValidationTypeEmailConfirmation
};

@interface MBValidationError : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *details;
+ (instancetype)errorWithName:(NSString*)name details:(NSString*)details;
+ (instancetype)errorByAppendingErrors:(NSArray*)errors withTitleSeparator:(NSString*)titleSep detailsSeparator:(NSString*)detailsSep;
@end

@class MBFormCoordinator;
@protocol MBFormDelegate <NSObject, UITextFieldDelegate, UITextViewDelegate>
- (void)formDidComplete:(MBFormCoordinator*)form;
@optional
- (MBFieldValidationType)validationTypeForField:(id)field atIndex:(NSUInteger)index;
- (MBValidationError*)validationErrorForField:(id)field validatonType:(MBFieldValidationType)type atIndex:(NSUInteger)index;
- (BOOL)fieldRequired:(id)field atIndex:(NSUInteger)index validationType:(MBFieldValidationType)type;
- (void)validationDidFailForField:(id)field atIndex:(NSUInteger)index withError:(MBValidationError*)error;
@end

@interface MBFormCoordinator : NSObject
@property (nonatomic, weak) id<MBFormDelegate> delegate;
+ (instancetype)newWithDelegate:(id<MBFormDelegate>)delegate;
- (void)chainFields:(NSArray*)fields finishType:(UIReturnKeyType)type;
- (void)bindKeyPath:(NSString*)keypath ofObject:(id)object toField:(id)field;
- (void)advanceToFieldAfterField:(id)field;
- (void)populateTextFieldsWithValues:(NSArray*)values;
- (void)enumerateFields:(void(^)(id field, NSString *text, MBFieldValidationType type))block;

// used for unique validation types; if more than one found, returns nil
- (id)uniqueFieldForValidationType:(MBFieldValidationType)type;
- (NSString*)valueForFieldWithType:(MBFieldValidationType)type;
- (BOOL)isFieldRequired:(id)field;

typedef void (^MBValidationBlock)(NSArray *invalidFields, NSArray *respectiveErrors);
// block is only called if at least one textfield fails validation
- (BOOL)validateAllFieldsWithInvalidBlock:(MBValidationBlock)invalidBlock;
- (void)resignAllFields;
@end
