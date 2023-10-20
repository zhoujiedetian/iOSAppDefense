//
//  CXInjectDetection.m
//  Created by zhoujie on 2021/12/22.

#import "CXInjectDetection.h"
#import <dlfcn.h>
#import <mach-o/dyld.h>

@implementation CXInjectDetection

+ (void)load {
    [self performSelectorOnMainThread:@selector(shared) withObject:nil waitUntilDone:NO];
#ifndef DEBUG
    //注册回调，只要dylib被加载就会进入此回调
    _dyld_register_func_for_add_image(&cx_image_added);
#endif
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isInject = NO;
    }
    return self;
}

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static CXInjectDetection *inject;
    dispatch_once(&onceToken, ^{
        inject = [[CXInjectDetection alloc] init];
    });
    return inject;
}

#pragma clang diagnostic push
//"-Wunused-variable"这里就是警告的类型
#pragma clang diagnostic ignored "-Wunused-function"

static void cx_image_added(const struct mach_header *mh, intptr_t slide) {
    Dl_info image_info;
    int result = dladdr(mh, &image_info);
    if (result == 0) {
        return;
    }
    const char *image_name = image_info.dli_fname;
    //检测到第三方库,直接杀掉
    if (strstr(image_name, "DynamicLibraries") || strstr(image_name, "CydiaSubstrate")) {
        [CXInjectDetection shared].isInject = YES;
    }
}

#pragma clang diagnostic pop

@end
