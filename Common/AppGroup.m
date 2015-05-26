#import "AppGroup.h"

#define STR(x) @#x
#define STR2(x) STR(x)
static NSString * const kAppIdentifier = STR2(APP_IDENTIFIER);

@implementation AppGroup

+ (NSString *)appGroupID
{
    return [NSString stringWithFormat:@"group.%@", kAppIdentifier];
}

+ (NSString *)pathForResource:(NSString *)subpath
{
    NSString *containerPath = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:[self appGroupID]].path;
    return [containerPath stringByAppendingPathComponent:subpath];
}

+ (NSUserDefaults*)userDefaults
{
    return [[NSUserDefaults alloc] initWithSuiteName: [self appGroupID]];
}



@end
