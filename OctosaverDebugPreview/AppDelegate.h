//
//  AppDelegate.h
//  OctosaverDebugPreview
//
//  Created by Marcus Kida on 05.09.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <ScreenSaver/ScreenSaver.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) IBOutlet ScreenSaverView * view;
@property (nonatomic, retain) NSTimer * timer;

@end
