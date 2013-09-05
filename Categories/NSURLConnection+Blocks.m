//
//  NSURLRequest+NSURLRequest_Blocks.m
//
//  Created by Rui Peres on 7/11/12.
//

#import "NSURLConnection+Blocks.h"

@implementation NSURLConnection (NSURLConnection_Blocks)

static CompletionBlock _completionBlock;
static FailBlock _failBlock;
static CleanBlock _cleanBlock;
static NSMutableData *webData;
static NSInteger responseCode;

#pragma mark - Public Methods

+ (NSURLConnection*)connectionWithRequest:(NSURLRequest*)request onCompletion:(CompletionBlock)completionBlock onFail:(FailBlock)failBlock
{
    _cleanBlock = [^{
        _failBlock = nil;
        _completionBlock = nil;
        _cleanBlock = nil;
        webData = nil;
    } copy];
    
    _completionBlock = nil;
    _failBlock = nil;
    
    _completionBlock = [completionBlock copy];
    _failBlock = [failBlock copy];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:[self class]];
    
    return connection;
}

#pragma mark - NSURLConnectionDelegate Implementation

+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (_failBlock)
    {
        _failBlock(error, responseCode);
    }
    
    if (_cleanBlock)
    {
        _cleanBlock();
    }
}

+ (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (_completionBlock)
    {
        _completionBlock([NSData dataWithData:webData], responseCode);
    }
    
    if (_cleanBlock)
    {
        _cleanBlock();
    }

}

+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{    
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    responseCode = [httpResponse statusCode];
    
    webData = [NSMutableData dataWithLength:1024];
	[webData setLength: 0];
}

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}

@end
