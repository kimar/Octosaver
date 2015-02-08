//
//  OctosaverView.m
//  Octosaver
//
//  Created by Marcus Kida on 05.09.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "OctosaverView.h"
#import "Octoparser.h"
#import "NSImage+AverageColor.h"
#import "NSColor+InverseColor.h"

@interface OctosaverView ()
{
    Octoparser *_parser;
    NSInteger _counter;
}
@end

@implementation OctosaverView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self initialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    
    return self;
}

- (void) initialization
{
    [self setAnimationTimeInterval:1/30.0f];

    _counter = 200;
    _parser = [[Octoparser alloc] init];

    self.imageView = [[NSImageView alloc] initWithFrame:[self activeScreenRect]];
    [self addSubview:self.imageView];
    
    self.label = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, self.bounds.size.width, 100)];
    self.label.autoresizingMask = NSViewWidthSizable;
    self.label.alignment = NSCenterTextAlignment;
    self.label.backgroundColor = [NSColor clearColor];
    [self.label setEditable:NO];
    [self.label setBezeled:NO];
    self.label.textColor = [NSColor blackColor];
    
    self.label.font = [NSFont fontWithName:@"Helvetica Neue" size:24.0];
    [self addSubview:self.label];
    
    [self refreshOctocat];
}

- (NSRect) activeScreenRect
{
    
    NSRect screenRect;
    NSArray *screenArray = [NSScreen screens];
    NSInteger screenCount = [screenArray count];
    
    for (NSInteger i = 0; i < screenCount; i++)
    {
        NSScreen *screen = [screenArray objectAtIndex:i];
        screenRect = [screen visibleFrame];
    }
    return screenRect;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
    [self drawOctocat];

    [[NSColor whiteColor] setFill];
    NSRectFill(rect);
}

- (void)animateOneFrame
{
    if(_counter == 0)
    {
        [self refreshOctocat];
        _counter = 200;
    }
    else
    {
        _counter--;
    }
    
    self.needsDisplay = YES;
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}

+ (NSBackingStoreType)backingStoreType {
    return NSBackingStoreBuffered;
}

#pragma mrk - Private
- (void) refreshOctocat
{
    [_parser getRandomOctocatFromOcotodex:^(NSImage *octocat, NSString *catname) {
        [self.imageView setImage:octocat];
        [self.label setStringValue:[catname stringByReplacingOccurrencesOfString:@"the " withString:@""]];
    }];
}

- (void) drawOctocat
{
    CGRect r = self.imageView.frame;
    r.origin.x = self.bounds.size.width / 2 - r.size.width / 2;
    r.origin.y = self.bounds.size.height / 2 - r.size.height / 2.4;
    self.imageView.frame = r;

    NSSize s = [self.label.stringValue sizeWithAttributes:@{NSFontAttributeName: self.label.font}];
    CGRect rl = self.label.frame;
    rl.size.height = s.height;
    rl.origin.y = self.imageView.frame.origin.y - 60;
    self.label.frame = rl;
    self.label.textColor = [NSColor blackColor];
    
}

@end
