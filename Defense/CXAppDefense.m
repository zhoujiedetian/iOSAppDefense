//
//  CXAppDefense.m
//  Created by zhoujie on 2021/12/22.

#import "CXAppDefense.h"
#import "CXPtrace.h"
@implementation CXAppDefense

+ (CXJailDetecteResult *)appDefense {
    CXJailDetecteResult *result;
    BOOL isOnM1 = false;
    if (@available(iOS 14.0, *)) {
        isOnM1 = [NSProcessInfo processInfo].isiOSAppOnMac;
    }
    if (isOnM1) {
        result = [CXJailDetecteResult new];
        return result;
    }
#ifndef DEBUG
    //检测设备是否越狱，如果越狱，则退出
    result = [CXJailBreakDetection isJailBreak];
    if (result.isJailBreak) {
        return result;
    }
    
    //检测是否有调试器
    if (antiForAttachToExit()) {
        result.isJailBreak = YES;
        result.reason = CXDefenseReasonTypeAttach;
        return result;
    }
    
    // 检测是否有第三库注入
    if ([CXInjectDetection shared].isInject) {
        result.isJailBreak = YES;
        result.reason = CXDefenseReasonTypeInject;
        return result;
    }
    
    // 检测到了重签名
    if (checkCodesign(@"cn.com.westone.chengxun")) {
        result.isJailBreak = YES;
        result.reason = CXDefenseReasonTypeCodeResign;
        return result;
    }
#endif
    if (!result) {
        result = [CXJailDetecteResult new];
    }
    return result;
}

bool  checkCodesign(NSString *id){
   // 描述文件路径
   NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
   // 读取application-identifier  注意描述文件的编码要使用:NSASCIIStringEncoding
   NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
   NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];

   for (int i = 0; i < embeddedProvisioningLines.count; i++) {
       if ([embeddedProvisioningLines[i] rangeOfString:@"application-identifier"].location != NSNotFound) {

           NSInteger fromPosition = [embeddedProvisioningLines[i+1] rangeOfString:@""].location+8;

           NSInteger toPosition = [embeddedProvisioningLines[i+1] rangeOfString:@""].location;

           NSRange range;
           range.location = fromPosition;
           range.length = toPosition - fromPosition;

           NSString *fullIdentifier = [embeddedProvisioningLines[i+1] substringWithRange:range];
           NSArray *identifierComponents = [fullIdentifier componentsSeparatedByString:@"."];
           NSString *appIdentifier = [identifierComponents firstObject];

           // 对比签名ID
           if (![appIdentifier isEqual:id]) {
               //exit
               return YES;
           }
           break;
       }
   }
    return NO;
}

@end
