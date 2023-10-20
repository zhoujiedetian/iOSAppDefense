//
//  CXJailBreakDetection.h
//  Created by zhoujie on 2021/12/22.

#import <Foundation/Foundation.h>
#import "CXDefenseReason.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXJailDetecteResult : NSObject
@property(nonatomic, assign) BOOL isJailBreak;
@property(nonatomic, assign) CXDefenseReasonType reason;
@end

@interface CXJailBreakDetection : NSObject
/// 检测当前设备是否越狱
+ (CXJailDetecteResult *)isJailBreak;
@end

NS_ASSUME_NONNULL_END
