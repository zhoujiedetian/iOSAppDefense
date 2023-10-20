//
//  CXJailBreakVC.m
//  Created by zhoujie on 2022/12/1.

#import "CXJailBreakVC.h"
#import "XCAlertView.h"
#import "CXJailBreakDetection.h"
#import <Bugly/Bugly.h>
@interface CXJailBreakVC ()

@end

@implementation CXJailBreakVC

#pragma mark ********* LifeCircle *********
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self _showJailBreakAlert];
}

#pragma mark ********* SetUpView *********
- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark ********* EventResponse *********

#pragma mark ********* PublicMethod *********

#pragma mark ********* PrivateMethod *********
- (void)_showJailBreakAlert {
    if ( !_result || !_result.isJailBreak) {
        return;
    }
    NSString *content = @"";
    switch (_result.reason) {
        case CXDefenseReasonTypeNone:
            break;
        default:
            content = [NSString stringWithFormat:@"%@", @(_result.reason)];
            break;
    }
    NSString *showTip = [NSString stringWithFormat:@"%@(%@)", CXLocalizedString(@"current environment is unsafe", nil), content];
    [XCAlertView AlertViewWithTitle:nil message:showTip cancelTitle:CXLocalizedString(@"ok", nil) acitons:@[] style:XCAlertStyle_Alert inView:self itemblock:^(NSInteger itemIndex) {
        exit(0);
    }];
    [Bugly reportError:[NSError errorWithDomain:showTip code:-1 userInfo:nil]];
}
@end
