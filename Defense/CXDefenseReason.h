//
//  CXDefenseReason.h
//  Created by zhoujie on 2022/11/30.

#ifndef CXDefenseReason_h
#define CXDefenseReason_h

typedef NS_ENUM(NSInteger, CXDefenseReasonType) {
    CXDefenseReasonTypeNone = 0,                            // 没有越狱
    CXDefenseReasonTypeCydiaInstalled = 1,                  // 安装了Cydia
    CXDefenseReasonTypeAppCydia = 11,                       // App Cydia
    CXDefenseReasonTypeAppBlackra1n,                        // App Blackra1n
    CXDefenseReasonTypeAppFakeCarrier,                      // App FakeCarrier
    CXDefenseReasonTypeAppIcy,                              // App Icy
    CXDefenseReasonTypeAppIntelliScreen,                    // App IntelliScreen
    CXDefenseReasonTypeAppMxTube,                           // App MxTube
    CXDefenseReasonTypeAppRock,                             // App Rock
    CXDefenseReasonTypeAppSBSettings,                       // App SBSettings
    CXDefenseReasonTypeAppWinterBoard,                      // App WinterBoard
    CXDefenseReasonTypePathLiveClock = 21,                  // SystemPath LiveClock.plist
    CXDefenseReasonTypePathVeency,                          // SystemPath Veency.plist
    CXDefenseReasonTypePathLibApt,                          // SystemPath Lib/apt
    CXDefenseReasonTypePathLibCydia,                        // SystemPath Lib/cydia
    CXDefenseReasonTypePathThemes,                          // SystemPath Themes
    CXDefenseReasonTypePathStash,                           // SystemPath Stash
    CXDefenseReasonTypePathCydiaLog,                        // SystemPath Cydia.log
    CXDefenseReasonTypePathBbot,                            // SystemPath Bbot.plist
    CXDefenseReasonTypePathStartup,                         // SystemPath Startup.plist
    CXDefenseReasonTypePathBinSshd,                         // SystemPath Bin/sshd
    CXDefenseReasonTypePathSftp,                            // SystemPath Sftp-server
    CXDefenseReasonTypePathSbinSshd,                        // SystemPath Sbin/sshd
    CXDefenseReasonTypePathEtcApt,                          // SystemPath Etc/apt
    CXDefenseReasonTypePathBash,                            // SystemPath Bash
    CXDefenseReasonTypePathMobileSubstrate,                 // SystemPath MobileSubstrate
    CXDefenseReasonTypeAttach = 41,                         // 检测到了调试器
    CXDefenseReasonTypeInject = 51,                         // 检测到了第三方库注入
    CXDefenseReasonTypeCodeResign = 61                      // 检测到了重签名
};

#endif /* CXDefenseReason_h */
