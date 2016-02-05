//
//	ReaderDemoController.m
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

#import "ReaderDemoController.h"
#import "ReaderViewController.h"
#import "ReaderConstants.h"

@interface ReaderDemoController () <ReaderViewControllerDelegate> {
	NSMutableArray *_images;
}

@end

@implementation ReaderDemoController

#pragma mark - Constants

#define DEMO_VIEW_CONTROLLER_PUSH FALSE

#pragma mark - UIViewController methods

/*
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		// Custom initialization
	}

	return self;
}
*/

/*
- (void)loadView
{
	// Implement loadView to create a view hierarchy programmatically, without using a nib.
}
*/

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor clearColor]; // Transparent

	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

	NSString *name = [infoDictionary objectForKey:@"CFBundleName"];

	NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];

	self.title = [[NSString alloc] initWithFormat:@"%@ v%@", name, version];

	CGSize viewSize = self.view.bounds.size;

	CGRect labelRect = CGRectMake(0.0f, 0.0f, 80.0f, 32.0f);

	UILabel *tapLabel = [[UILabel alloc] initWithFrame:labelRect];

	tapLabel.text = @"Tap";
	tapLabel.textColor = [UIColor whiteColor];
	tapLabel.textAlignment = NSTextAlignmentCenter;
	tapLabel.backgroundColor = [UIColor clearColor];
	tapLabel.font = [UIFont systemFontOfSize:24.0f];
	tapLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	tapLabel.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	tapLabel.center = CGPointMake(viewSize.width * 0.5f, viewSize.height * 0.5f);

	[self.view addSubview:tapLabel]; 

	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	//singleTap.numberOfTouchesRequired = 1; singleTap.numberOfTapsRequired = 1; //singleTap.delegate = self;
	[self.view addGestureRecognizer:singleTap]; 
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:NO animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:YES animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
#ifdef DEBUG
	NSLog(@"%s", __FUNCTION__);
#endif

	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) // See README
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	else
		return YES;
}

/*
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	//if (fromInterfaceOrientation == self.interfaceOrientation) return;
}
*/

- (void)didReceiveMemoryWarning
{
#ifdef DEBUG
	NSLog(@"%s", __FUNCTION__);
#endif

	[super didReceiveMemoryWarning];
}

#pragma mark - UIGestureRecognizer methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
	NSString *phrase = nil; // Document password (for unlocking most encrypted PDF files)

	NSArray *pdfs = [[NSBundle mainBundle] pathsForResourcesOfType:@"pdf" inDirectory:nil];

	NSString *filePath = [pdfs firstObject]; assert(filePath != nil); // Path to first PDF file

	ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:phrase];
	
	// Customize translation
	[ReaderConstants setDoneTranslation:@"plop"];
	[ReaderConstants setPageFormatTranslation:@"%d plip %d"];

	if (document != nil) // Must have a valid ReaderDocument object in order to proceed with things
	{
		[document fileName:@"My Super custom Name"];
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
//		[readerViewController removeNavigation:YES];
		
		
		// Try to add custom button in menu
		_images = [NSMutableArray array];
		UIImage *img = [UIImage imageNamed:@"Reader-Mark-N.png"];
		UIImage *imgSelected = [UIImage imageNamed:@"Reader-Mark-Y.png"];
		NSDictionary *info = @{ @"tag": @100, @"image": img, @"image_selected": imgSelected };
		[_images addObject:info];
		
		info = @{ @"tag": @101, @"image": img, @"image_selected": imgSelected };
		[_images addObject:info];
		
		info = @{ @"tag": @102, @"image": img, @"image_selected": imgSelected };
		[_images addObject:info];
		
		info = @{ @"tag": @102, @"title": @"cool ok" };
		[_images addObject:info];
		
		
		
		// Wait the ui view controller is pushed and loaded in navigation controller
		dispatch_async(dispatch_get_main_queue(), ^{
			[[readerViewController getMainToolbar] addOptionalButtons:_images];
			[readerViewController hideHUD];
//			[readerViewController showHUD];
//			[readerViewController performSelector:@selector(removeAndHideNavigation) withObject:nil afterDelay:2.5];
//			[self performSelector:@selector(enableNavigation:) withObject:readerViewController afterDelay:5.];
		});
		readerViewController.view.backgroundColor = [UIColor blackColor];
        

		readerViewController.delegate = self; // Set the ReaderViewController delegate to self

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

		[self.navigationController pushViewController:readerViewController animated:YES];

#else // present in a modal view controller

		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;

		[self presentViewController:readerViewController animated:YES completion:NULL];

#endif // DEMO_VIEW_CONTROLLER_PUSH
	}
	else // Log an error so that we know that something went wrong
	{
		NSLog(@"%s [ReaderDocument withDocumentFilePath:'%@' password:'%@'] failed.", __FUNCTION__, filePath, phrase);
	}
}

- (void) enableNavigation:(ReaderViewController *)readerViewController
{
	NSLog(@"readerViewController.removeNavigation : %d", [readerViewController navigationIsRemoved]);
	[readerViewController removeNavigation:NO];
	NSLog(@"readerViewController.removeNavigation : %d", [readerViewController navigationIsRemoved]);
}

- (void)willShowHUDReaderViewController:(ReaderViewController *)viewController
{
	NSLog(@"willShowHUDReaderViewController");
}

- (void)willHideHUDReaderViewController:(ReaderViewController *)viewController
{
	NSLog(@"willHideHUDReaderViewController");
}

#pragma mark - ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController popViewControllerAnimated:YES];

#else // dismiss the modal view controller

	[self dismissViewControllerAnimated:YES completion:NULL];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)readerViewController:(ReaderViewController *)viewController didChangePage:(NSInteger)page
{
	NSLog(@"readerViewController didChangePage : %d", page);
}

- (void)readerViewController:(ReaderViewController *)viewController buttonTouchHandler:(UIButton *)button
{
	NSLog(@"readerViewController buttonTouchHandler : %@", button);
}

@end
