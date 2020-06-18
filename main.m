//
//  main.m
//  JMOrderCoreKitDemo
//
//  Created by lzj<lizhijian_21@163.com> on 2020/4/21.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
