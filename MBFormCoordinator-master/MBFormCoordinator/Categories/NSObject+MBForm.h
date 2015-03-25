
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (MBForm)
- (void)setDynamicValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)policy;
- (id)getDynamicValueForKey:(NSString *)key;
@end
