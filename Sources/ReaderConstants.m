//
//	ReaderConstants.m
//	Reader v2.8.7
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2016 Julius Oklamcak. All rights reserved.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//	of the Software, and to permit persons to whom the Software is furnished to
//	do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "ReaderConstants.h"

static NSString *const kReaderCopyrightNotice = @"Reader v2.x.y • Copyright © 2011-2016 Julius Oklamcak. All rights reserved.";

@interface ReaderConstants() {
	
}

@end

@implementation ReaderConstants

+ (instancetype) sharedInstance
{
    static ReaderConstants *sharedObject;
	if( sharedObject == nil ) {
		sharedObject = [[super allocWithZone:NULL] init];
	}
	return sharedObject;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (NSString *) doneTranslation
{
	ReaderConstants *shared = [ReaderConstants sharedInstance];
	if( !shared.doneTranslation ) {
		shared.doneTranslation = NSLocalizedString(@"Done", @"button");
	}
	return shared.doneTranslation;
}

+ (void) setDoneTranslation:(NSString *)doneTranslation
{
	ReaderConstants *shared = [ReaderConstants sharedInstance];
	shared.doneTranslation = doneTranslation;
}

+ (NSString *) pageFormatTranslation
{
	ReaderConstants *shared = [ReaderConstants sharedInstance];
	if( !shared.pageFormatTranslation ) {
		shared.pageFormatTranslation = NSLocalizedString(@"%i of %i", @"format"); // Format
	}
	return shared.pageFormatTranslation;
}

+ (void) setPageFormatTranslation:(NSString *)pageFormatTranslation
{
	ReaderConstants *shared = [ReaderConstants sharedInstance];
	shared.pageFormatTranslation = pageFormatTranslation;
}

@end
