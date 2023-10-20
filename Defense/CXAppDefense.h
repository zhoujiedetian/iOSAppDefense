//
//  CXAppDefense.h
//  Created by zhoujie on 2021/12/22.

#import <Foundation/Foundation.h>
#import "CXJailBreakDetection.h"
#import "CXInjectDetection.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXAppDefense : NSObject
/// 应用逆向防护
+ (id)appDefense;
@end

NS_ASSUME_NONNULL_END
