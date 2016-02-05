//
//	ReaderViewController.h
//	Reader v2.8.6
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011-2015 Julius Oklamcak. All rights reserved.
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

#import <UIKit/UIKit.h>

#import "ReaderDocument.h"
#import "ReaderMainToolbar.h"
#import "ReaderMainPagebar.h"

@class ReaderViewController;

@protocol ReaderViewControllerDelegate <NSObject>

@optional // Delegate protocols

- (void)dismissReaderViewController:(ReaderViewController *)viewController;
- (void)readerViewController:(ReaderViewController *)viewController didChangePage:(NSInteger)page;
- (void)willShowHUDReaderViewController:(ReaderViewController *)viewController;
- (void)willHideHUDReaderViewController:(ReaderViewController *)viewController;
- (void)readerViewController:(ReaderViewController *)viewController buttonTouchHandler:(UIButton *)button;

@end

@interface ReaderViewController : UIViewController

@property (nonatomic, weak, readwrite) id <ReaderViewControllerDelegate> delegate;
//@property (nonatomic, assign) BOOL removeNavigation;

- (instancetype)initWithReaderDocument:(ReaderDocument *)object;

- (void)showDocumentPage:(NSInteger)page;
- (void)closeDocument;
- (ReaderDocument *)getDocument;
- (ReaderMainToolbar *)getMainToolbar;
- (ReaderMainPagebar *)getMainPagebar;
- (void)removeNavigation:(BOOL)removed;
- (BOOL)navigationIsRemoved;
- (void)removeAndHideNavigation;
- (void)showHUD;
- (void)hideHUD;

@end
