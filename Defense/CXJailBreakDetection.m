//
//  CXJailBreakDetection.m
//  Created by zhoujie on 2021/12/22.

#import "CXJailBreakDetection.h"


@implementation CXJailDetecteResult

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isJailBreak = NO;
        self.reason = CXDefenseReasonTypeNone;
    }
    return self;
}
@end

@implementation CXJailBreakDetection

+ (CXJailDetecteResult *)isJailBreak {
    CXJailDetecteResult *result = [CXJailDetecteResult new];
    // 是否安装了Cydia
    if ([self hasCydiaInstalled] != CXDefenseReasonTypeNone) {
        result.isJailBreak = YES;
        result.reason = CXDefenseReasonTypeCydiaInstalled;
        return result;
    }
    
    // 是否安装了具体的越狱app
    CXDefenseReasonType containSuspiciousAppType = [self isContainSuspiciousApps];
    if (containSuspiciousAppType != CXDefenseReasonTypeNone) {
        result.isJailBreak = YES;
        result.reason = containSuspiciousAppType;
        return result;
    }
    
    // 是否存在一些越狱相关的文件夹
    CXDefenseReasonType containSuspiciousSystemPathType = [self isContainSuspiciousSystemPath];
    if (containSuspiciousSystemPathType != CXDefenseReasonTypeNone) {
        result.isJailBreak = YES;
        result.reason = containSuspiciousSystemPathType;
        return result;
    }
    
    return result;
}

+ (CXDefenseReasonType)hasCydiaInstalled {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]] ? CXDefenseReasonTypeCydiaInstalled : CXDefenseReasonTypeNone;
}

+ (CXDefenseReasonType)isContainSuspiciousApps {
    NSArray *apps = @[@"/Applications/Cydia.app",
                      @"/Applications/blackra1n.app",
                      @"/Applications/FakeCarrier.app",
                      @"/Applications/Icy.app",
                      @"/Applications/IntelliScreen.app",
                      @"/Applications/MxTube.app",
                      @"/Applications/RockApp.app",
                      @"/Applications/SBSettings.app",
                      @"/Applications/WinterBoard.app"];
    for (NSString *path in apps) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if ([path isEqualToString:@"/Applications/Cydia.app"]) {
                return CXDefenseReasonTypeAppCydia;
            }
            if ([path isEqualToString:@"/Applications/blackra1n.app"]) {
                return CXDefenseReasonTypeAppBlackra1n;
            }
            if ([path isEqualToString:@"/Applications/FakeCarrier.app"]) {
                return CXDefenseReasonTypeAppFakeCarrier;
            }
            if ([path isEqualToString:@"/Applications/Icy.app"]) {
                return CXDefenseReasonTypeAppIcy;
            }
            if ([path isEqualToString:@"/Applications/IntelliScreen.app"]) {
                return CXDefenseReasonTypeAppIntelliScreen;
            }
            if ([path isEqualToString:@"/Applications/MxTube.app"]) {
                return CXDefenseReasonTypeAppMxTube;
            }
            if ([path isEqualToString:@"/Applications/RockApp.app"]) {
                return CXDefenseReasonTypeAppRock;
            }
            if ([path isEqualToString:@"/Applications/SBSettings.app"]) {
                return CXDefenseReasonTypeAppSBSettings;
            }
            if ([path isEqualToString:@"/Applications/WinterBoard.app"]) {
                return CXDefenseReasonTypeAppWinterBoard;
            }
        }
    }
    return CXDefenseReasonTypeNone;
}

+ (CXDefenseReasonType)isContainSuspiciousSystemPath {
    NSArray *systemPaths = @[@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
                             @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
                             @"/private/var/lib/apt",
                             @"/private/var/lib/apt/",
                             @"/private/var/lib/cydia",
                             @"/private/var/mobile/Library/SBSettings/Themes",
                             @"/private/var/stash",
                             @"/private/var/tmp/cydia.log",
                             @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
                             @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
                             @"/usr/bin/sshd",
                             @"/usr/libexec/sftp-server",
                             @"/usr/sbin/sshd",
                             @"/etc/apt",
                             @"/bin/bash",
                             @"/Library/MobileSubstrate/MobileSubstrate.dylib"];
    for (NSString *path in systemPaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if ([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist"]) {
                return CXDefenseReasonTypePathLiveClock;
            }
            if ([path isEqualToString:@"/Library/MobileSubstrate/DynamicLibraries/Veency.plist"]) {
                return CXDefenseReasonTypePathVeency;
            }
            if ([path isEqualToString:@"/private/var/lib/apt"] || [path isEqualToString:@"/private/var/lib/apt/"]) {
                return CXDefenseReasonTypePathLibApt;
            }
            if ([path isEqualToString:@"/private/var/lib/cydia"]) {
                return CXDefenseReasonTypePathLibCydia;
            }
            if ([path isEqualToString:@"/private/var/mobile/Library/SBSettings/Themes"]) {
                return CXDefenseReasonTypePathThemes;
            }
            if ([path isEqualToString:@"/private/var/stash"]) {
                return CXDefenseReasonTypePathStash;
            }
            if ([path isEqualToString:@"/private/var/tmp/cydia.log"]) {
                return CXDefenseReasonTypePathCydiaLog;
            }
            if ([path isEqualToString:@"/System/Library/LaunchDaemons/com.ikey.bbot.plist"]) {
                return CXDefenseReasonTypePathBbot;
            }
            if ([path isEqualToString:@"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist"]) {
                return CXDefenseReasonTypePathStartup;
            }
            if ([path isEqualToString:@"/usr/bin/sshd"]) {
                return CXDefenseReasonTypePathBinSshd;
            }
            if ([path isEqualToString:@"/usr/libexec/sftp-server"]) {
                return CXDefenseReasonTypePathSftp;
            }
            if ([path isEqualToString:@"/usr/sbin/sshd"]) {
                return CXDefenseReasonTypePathSbinSshd;
            }
            if ([path isEqualToString:@"/etc/apt"]) {
                return CXDefenseReasonTypePathEtcApt;
            }
            if ([path isEqualToString:@"/bin/bash"]) {
                return CXDefenseReasonTypePathBash;
            }
            if ([path isEqualToString:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
                return CXDefenseReasonTypePathMobileSubstrate;
            }
        }
    }
    return CXDefenseReasonTypeNone;
}
@end
