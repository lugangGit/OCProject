//
//  TracingPCs.m
//  OC-Project
//
//  Created by Founder on 2022/6/27.
//

#import "TracingPCs.h"
#include <stdint.h>
#include <stdio.h>
#include <sanitizer/coverage_interface.h>

#import <dlfcn.h>
#import <libkern/OSAtomic.h>

@implementation TracingPCs

//原子队列 线程安全 先进后出 (/*只能保存结构体*/)
static OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

typedef struct {
    void * pc;
    void * next;
}SymbolNode;

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,
                                                    uint32_t *stop) {
    static uint64_t N;  // Counter for the guards.
    if (start == stop || *start) return;  // Initialize only once.
    printf("INIT: %p %p\n", start, stop);
//    for (uint32_t *x = start; x < stop; x++)
//      *x = ++N;  // Guards should start from 1.

      /// 符号的个数
//      NSLog(@"%llu", N);
}

// This callback is inserted by the compiler on every edge in the
// control flow (some optimizations apply).
// Typically, the compiler will emit the code like this:
//    if(*guard)
//      __sanitizer_cov_trace_pc_guard(guard);
// But for large functions it will emit a simple call:
//    __sanitizer_cov_trace_pc_guard(guard);
void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    if (!*guard) return;  // Duplicate the guard check.
    // If you set *guard to 0 this code will not be called again for this edge.
    // Now you can get the PC and do whatever you want:
    //   store it somewhere or symbolize it and print right away.
    // The values of `*guard` are as you set them in
    // __sanitizer_cov_trace_pc_guard_init and so you can make them consecutive
    // and use them to dereference an array or a bit vector.
    void *PC = __builtin_return_address(0);
//    char PcDescr[1024];
    // This function is a part of the sanitizer run-time.
    // To use it, link with AddressSanitizer or other sanitizer.
    //  __sanitizer_symbolize_pc(PC, "%p %F %L", PcDescr, sizeof(PcDescr));
//    printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
    
    /// 获取启动时需要的符号，手动添加到order文件中
    /// #import <dlfcn.h>
    Dl_info info;
    dladdr(PC, &info);
//    NSLog(@"dli_fname -- %s", info.dli_fname);
//    NSLog(@"dli_fbase -- %p", info.dli_fbase);
//    NSLog(@"dli_sname -- %s", info.dli_sname);
//    NSLog(@"dli_saddr -- %p", info.dli_saddr);
    
    /// SymbolNode 原子队列保证线程安全
    /// #import <libkern/OSAtomic.h>
    SymbolNode *node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC,NULL};
    
    /// 插入结构体
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));
}

+ (void)writeOrderFile {
    //创建数组
    NSMutableArray *symbleNames = [NSMutableArray array];
    while (YES) {
        SymbolNode *node = OSAtomicDequeue(&symbolList, offsetof(SymbolNode, next));
        if (node == NULL) {
            break;;
        }
        Dl_info info;
        dladdr(node->pc, &info);
        //转为OC字符串方便操作
        NSString *name = @(info.dli_sname);
        
        BOOL isObjc = [name hasPrefix:@"+["] || [name hasPrefix:@"-["];
        NSString * symbolName = isObjc ? name : [@"_" stringByAppendingString:name];
        NSLog(@"***%@", symbolName);
        
        if (![symbleNames containsObject:symbolName]){
            [symbleNames addObject:symbolName];
        }
    }
    // 去掉writeOrderFile方法(因为启动时，不会调用它)
    [symbleNames removeObject:[NSString stringWithFormat:@"%s", __FUNCTION__]];
        
    NSArray *funcs = [[symbleNames reverseObjectEnumerator] allObjects];
    
    NSString *funcStr = [funcs componentsJoinedByString:@"\n"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"lg.order"];
    NSData *file = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:file attributes:nil];
    if (result) {
        //获取沙盒主目录路径
        NSLog(@"===%@",NSHomeDirectory());
    }else {
        NSLog(@"order文件写入错误");
    }
}

@end
