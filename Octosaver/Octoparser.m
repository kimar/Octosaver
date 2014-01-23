//
//  Octoparser.m
//  Octosaver
//
//  Created by Marcus Kida on 05.09.13.
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import "Octoparser.h"
#import "TFHpple.h"
#import "NSURLConnection+Blocks.h"

@implementation Octoparser

- (id) init
{
    if(self = [super init])
    {

    }
    return self;
}

- (void) getRandomOctocatFromOcotodex:(void(^)(NSImage *octocat, NSString *catname))completion
{
    NSURL *githubUrl = [NSURL URLWithString:@"http://octodex.github.com"];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:githubUrl]
                              onCompletion:^(NSData *data, NSInteger statusCode) {
                                  TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
                                  NSArray *elements = [doc searchWithXPathQuery:@"//a[@class='preview-image']/img"];
                                  NSUInteger randomIndex = arc4random() % [elements count];
                                  TFHppleElement *element = [elements objectAtIndex:randomIndex];
                                  NSDictionary *attributes = [element attributes];
                                  NSURL *url = [NSURL URLWithString:[@"http://octodex.github.com/" stringByAppendingString:[attributes objectForKey:@"data-src"]]];

                                  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                                      NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
                                      NSImage *image = [[NSImage alloc] initWithData:imageData];
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          completion(image, [attributes objectForKey:@"alt"]);
                                      });
                                  });
                              }
                                    onFail:^(NSError *error, NSInteger statusCode) {
                                        completion(nil, nil);
                                    }];
}

@end
