#include <dlfcn.h>
#include <sys/sysctl.h>

#pragma clang diagnostic push
//"-Wunused-variable"这里就是警告的类型
#pragma clang diagnostic ignored "-Wunused-function"


#pragma mark ********* PTrace *********
/*
 lldb调试的原理：debugserver
 在越狱环境下，通过lldb连接手机的debugserver，然后通过debugserver来调试某个app
 而debugserver是通过ptrace函数来调试app
 */
#ifndef PT_DENY_ATTACH
//阻止调试器附加
#define PT_DENY_ATTACH  31
#endif
int ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);
static __attribute__((always_inline)) void antiForCantAttach() {
    ptrace(PT_DENY_ATTACH, 0, 0, 0);
}

#pragma mark ********* sysctl *********
/*
 当目标进程被调试时，会有一个标志位表明自己正在被调试
 通过sysctl获取标志位来得到当前的调试状态
 */
static __attribute__((always_inline)) BOOL antiForAttachToExit() {
    int name[] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()};
    u_int nameLen = sizeof(name) / sizeof(*name);
    struct kinfo_proc oldp;
    size_t oldLenp = sizeof(oldp);
    int result = sysctl(name, nameLen, &oldp, &oldLenp, NULL, 0);
    if (result == -1) {
        //错误处理
        return NO;
    }
    if ((oldp.kp_proc.p_flag & P_TRACED) != 0) {
        //检测到调试器，退出
        return YES;
    }
    return NO;
}
#pragma clang diagnostic pop
