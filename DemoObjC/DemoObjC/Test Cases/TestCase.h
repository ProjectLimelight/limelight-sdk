//
//  TestCase.h
//  DemoObjC
//
// © 2026 Limelight Inc. All Rights Reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCase : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *storyboardId;
@property (nonatomic, copy, nullable) void (^configurationClosure)(UIViewController *vc);

- (instancetype)initWithTitle:(NSString *)title
                 storyboardId:(NSString *)storyboardId
         configurationClosure:(nullable void (^)(UIViewController *vc))configurationClosure;

- (UIViewController *)makeViewController;

+ (NSDictionary<NSString *, NSArray<TestCase *> *> *)testCases;
+ (nullable NSNumber *)indexOfSection:(NSString *)section;
+ (nullable NSString *)sectionKeyOfIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
