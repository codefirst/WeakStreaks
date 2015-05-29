#import <Foundation/Foundation.h>

// AppGroupに関係する情報のラッパ。
//
// 個人アカウントを使っているため、ユーザに応じてAppGroup名を変える必要がある。
// AppGroup名はConfig.xcconfig内でCPPマクロとして定義されているため、Swiftからは読むことができない。
// そのためObjective-Cで記述する。
@interface AppGroup : NSObject

+ (NSString *)appGroupID;
+ (NSString *)pathForResource:(NSString *)subpath;
+ (NSUserDefaults*)userDefaults;
@end
