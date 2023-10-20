//
//  CXInjectDetection.h
//  Created by zhoujie on 2021/12/22.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXInjectDetection : NSObject
@property(nonatomic, assign) BOOL isInject;
+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
