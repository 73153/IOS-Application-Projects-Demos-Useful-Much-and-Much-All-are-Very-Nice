
#import "NSObject+MBForm.h"

@implementation NSObject (MBForm)

- (void)setDynamicValue:(id)value forKey:(NSString *)key associationPolicy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject(self, (__bridge const void *)(key), value, policy);
}

- (id)getDynamicValueForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

@end
