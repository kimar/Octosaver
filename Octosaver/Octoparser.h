//
//  Octoparser.h
//  Octosaver
//
//  Created by Marcus Kida on 05.09.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Octoparser : NSObject

- (void) getRandomOctocatFromOcotodex:(void(^)(NSImage *octocat, NSString *catname))completion;

@property (copy, nonatomic) void (^completionBlock)(NSError *error, NSData *data);

@end
