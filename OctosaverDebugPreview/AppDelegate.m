//
//  AppDelegate.m
//  OctosaverDebugPreview
//
//  Created by Marcus Kida on 05.09.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "AppDelegate.h"
#import "TFHpple.h"
#import "OctosaverView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.view.animationTimeInterval
                                                  target:self.view
                                                selector:@selector(animateOneFrame)
                                                userInfo:nil
                                                 repeats:YES];
}

@end
