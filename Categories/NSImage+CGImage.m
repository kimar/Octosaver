//
//  NSImage+CGImage.m
//  VillainousStyle
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "NSImage+CGImage.h"

#if !TARGET_OS_IPHONE
@implementation NSImage (CGImage)

//STUB add your category method implementations here

-(CGImageRef)CGImage{
	NSSize size = [self size];
	CGContextRef bitmapCtx = CGBitmapContextCreate(NULL/*data - pass NULL to let CG allocate the memory*/,
												   size.width,
												   size.height,
												   8 /*bitsPerComponent*/,
												   0 /*bytesPerRow - CG will calculate it for you if it's allocating the data.  This might get padded out a bit for better alignment*/,
												   [[NSColorSpace genericRGBColorSpace] CGColorSpace],
												   kCGBitmapByteOrder32Host|kCGImageAlphaPremultipliedFirst);
	
	[NSGraphicsContext saveGraphicsState];
	[NSGraphicsContext setCurrentContext:[NSGraphicsContext graphicsContextWithGraphicsPort:bitmapCtx flipped:NO]];
	[self drawInRect:NSMakeRect(0,0, size.width, size.height) fromRect:NSZeroRect/*sentinel, means "the whole thing*/ operation:NSCompositeCopy fraction:1.0];
	[NSGraphicsContext restoreGraphicsState];
	
	CGImageRef cgImage = CGBitmapContextCreateImage(bitmapCtx);
	CGContextRelease(bitmapCtx);
	return cgImage;
}

@end
#endif