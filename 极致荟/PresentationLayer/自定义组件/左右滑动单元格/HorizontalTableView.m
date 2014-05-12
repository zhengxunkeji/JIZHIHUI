//
//  HorizontalTableView.m
//  Scroller
//
//  Created by Martin Volerich on 5/22/10.
//  Copyright 2010 Martin Volerich - Bill Bear Technologies. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the "Software"), to deal in the Software without restriction, including without
// limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
// LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
// EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
// AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
// OR OTHER DEALINGS IN THE SOFTWARE.

#import "HorizontalTableView.h"

#define kColumnPoolSize 3

@interface HorizontalTableView() <UIScrollViewDelegate>

@property (nonatomic, retain) NSMutableArray *pageViews;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, readonly) NSUInteger currentPageIndex;
@property (nonatomic) NSUInteger physicalPageIndex;
@property (nonatomic, retain) NSMutableArray *columnPool;

- (void)prepareView;
- (void)layoutPages;
- (void)currentPageIndexDidChange;
- (NSUInteger)numberOfPages;
- (void)layoutPhysicalPage:(NSUInteger)pageIndex;
- (UIView *)viewForPhysicalPage:(NSUInteger)pageIndex;
- (void)removeColumn:(NSInteger)index;

@end


@implementation HorizontalTableView

@synthesize pageViews=_pageViews;
@synthesize scrollView=_scrollView;
@synthesize currentPageIndex=_currentPageIndex;
@synthesize delegate;
@synthesize columnPool;



- (void)refreshData {
    self.pageViews = [NSMutableArray array];
	// to save time and memory, we won't load the page views immediately
	NSUInteger numberOfPhysicalPages = [self numberOfPages];
	for (NSUInteger i = 0; i < numberOfPhysicalPages; ++i)
		[self.pageViews addObject:[NSNull null]];
    
    [self setNeedsLayout];
}

- (NSUInteger)numberOfPages {
	NSInteger numPages = 0;
    if (self.delegate)
        numPages = [self.delegate numberOfColumnsForTableView:self];
    return numPages;
}

- (UIView *)viewForPhysicalPage:(NSUInteger)pageIndex {
	NSParameterAssert(pageIndex >= 0);
	NSParameterAssert(pageIndex < [self.pageViews count]);
	
	UIView *pageView = nil;
	if ([self.pageViews objectAtIndex:pageIndex] == [NSNull null]) {
        
        if (self.delegate) {
            pageView = [self.delegate tableView:self viewForIndex:pageIndex];
            [self.pageViews replaceObjectAtIndex:pageIndex withObject:pageView];
            [self.scrollView addSubview:pageView];
        }
	} else {
		pageView = [self.pageViews objectAtIndex:pageIndex];
	}
//    NSLog(@"pageView.frame.origin:%@",NSStringFromCGPoint(pageView.frame.origin));
//    NSLog(@"pageView.frame.contentOffSet:%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    self.scrollView.contentOffset = CGPointMake(0, 0);
//    NSLog(@"scrollview.contentsize:%@",NSStringFromCGSize(self.scrollView.contentSize));
//    
//    NSLog(@"pageview.frame:%@",NSStringFromCGRect(pageView.frame));
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, 400);
    
	return pageView;
}

- (CGSize)pageSize {
    CGRect rect = self.scrollView.bounds;
	return rect.size;
}

- (CGFloat)columnWidth {
    if (!_columnWidth) {
        if (self.delegate) {
            CGFloat width = [self.delegate columnWidthForTableView:self];
            _columnWidth = [NSNumber numberWithFloat:width];
        }
    }
    return [_columnWidth floatValue];

}

- (BOOL)isPhysicalPageLoaded:(NSUInteger)pageIndex {
	return [self.pageViews objectAtIndex:pageIndex] != [NSNull null];
}

- (void)layoutPhysicalPage:(NSUInteger)pageIndex {
	UIView *pageView = [self viewForPhysicalPage:pageIndex];
    CGFloat viewWidth = pageView.bounds.size.width;
	CGSize pageSize = [self pageSize];
    
    CGRect rect = CGRectMake(viewWidth * pageIndex, 0, viewWidth, pageSize.height);
	pageView.frame = rect;
}

- (void)awakeFromNib {
    [self prepareView];
}

- (void)queueColumnView:(UIView *)vw {
    if ([self.columnPool count] >= kColumnPoolSize) {
        return;
    }
    [self.columnPool addObject:vw];
}

- (UIView *)dequeueColumnView {
    UIView *vw = [self.columnPool lastObject];
    if (vw) {
        [self.columnPool removeLastObject];
        NSLog(@"Supply from reuse pool");
    }
    return vw;
}

- (void)removeColumn:(NSInteger)index {
    if ([self.pageViews objectAtIndex:index] != [NSNull null]) {
        NSLog(@"Removing view at position %d", index);
        UIView *vw = [self.pageViews objectAtIndex:index];
        [self queueColumnView:vw];
        [vw removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}

- (void)currentPageIndexDidChange {
    CGSize pageSize = [self pageSize];
    CGFloat columnWidth = [self columnWidth];
    _visibleColumnCount = pageSize.width / columnWidth + 2;
    
    NSInteger leftMostPageIndex = -1;
    NSInteger rightMostPageIndex = 0;
    
    for (NSInteger i = -2; i < _visibleColumnCount; i++) {
        NSInteger index = _currentPhysicalPageIndex + i;
        if (index < [self.pageViews count] && (index >= 0)) {
            [self layoutPhysicalPage:index];
            if (leftMostPageIndex < 0)
                leftMostPageIndex = index;
            rightMostPageIndex = index;
        }
    }
    
    // clear out views to the left
    for (NSInteger i = 0; i < leftMostPageIndex; i++) {
        [self removeColumn:i];
    }
    
    // clear out views to the right
    for (NSInteger i = rightMostPageIndex + 1; i < [self.pageViews count]; i++) {
        [self removeColumn:i];
    }
}

- (void)layoutPages {
    CGSize pageSize = self.bounds.size;
	self.scrollView.contentSize = CGSizeMake([self.pageViews count] * [self columnWidth], pageSize.height);

}

- (id)init {
    self = [super init];
    if (self) {
        [self prepareView];
        

    }
    return self;
}

- (void)prepareView {
	self.columnPool = [[NSMutableArray alloc] initWithCapacity:kColumnPoolSize];
    _columnWidth = nil;
    [self setClipsToBounds:YES];
    
    self.autoresizesSubviews = YES;
    
    UIScrollView *scroller = [[UIScrollView alloc] init];
    CGRect rect = self.bounds;
    scroller.frame = rect;
    
    scroller.backgroundColor = [UIColor blackColor];
	scroller.delegate = self;
    scroller.autoresizesSubviews = YES;
    scroller.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	self.scrollView.pagingEnabled = YES;
	scroller.showsHorizontalScrollIndicator = YES;
	scroller.showsVerticalScrollIndicator = NO;
    scroller.alwaysBounceVertical = NO;
    self.scrollView = scroller;
    self.scrollView.pagingEnabled = YES;
	[self addSubview:scroller];
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMe:)];
    [self addGestureRecognizer:tapGesture];
}


- (NSUInteger)physicalPageIndex {
    NSUInteger page = self.scrollView.contentOffset.x / [self columnWidth];
    return page;
}

- (void)setPhysicalPageIndex:(NSUInteger)newIndex {
	self.scrollView.contentOffset = CGPointMake(newIndex * [self pageSize].width, 0);
}


#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //DLog(@"Did Scroll");
	
	NSUInteger newPageIndex = self.physicalPageIndex;
	if (newPageIndex == _currentPhysicalPageIndex) return;
	_currentPhysicalPageIndex = newPageIndex;
	_currentPageIndex = newPageIndex;
	
	[self currentPageIndexDidChange];
    
    CGSize rect = [self.scrollView contentSize];
    NSLog(@"CSize = %@", NSStringFromCGSize(rect));
    NSLog(@"CGFRAME = %@",NSStringFromCGRect(self.scrollView.frame));
    
    
    [self.delegate tableView:self didScrolledToColumn:self.currentPageIndex];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSLog(@"scrollViewDidEndDecelerating");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)layoutSubviews {
    [self layoutPages];
    [self currentPageIndexDidChange];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	// adjust frames according to the new page size - this does not cause any visible changes
	[self layoutPages];
	self.physicalPageIndex = _currentPhysicalPageIndex;
	
	// unhide
	for (NSUInteger pageIndex = 0; pageIndex < [self.pageViews count]; ++pageIndex)
		if ([self isPhysicalPageLoaded:pageIndex])
			[self viewForPhysicalPage:pageIndex].hidden = NO;
	
    self.scrollView.contentSize = CGSizeMake([self.pageViews count] * [self columnWidth], [self pageSize].height);

    [self currentPageIndexDidChange];
}

- (void)tapMe:(UITapGestureRecognizer *)tapGesture{
    UIView *pageView = [self.pageViews objectAtIndex:self.currentPageIndex];
    CGPoint tapPoint = [tapGesture locationInView:pageView];

    
    CGFloat itemWith = self.bounds.size.width/2;
    CGFloat itemHeight = self.bounds.size.height/2;
    CGRect itemOne = CGRectMake(0, 0, itemWith, itemHeight);
    CGRect itemTwo = CGRectMake(itemWith, 0, itemWith, itemHeight);
    CGRect itemThree = CGRectMake(0, itemHeight, itemWith, itemHeight);
    CGRect itemFour = CGRectMake(itemWith, itemHeight, itemWith, itemHeight);
    
    if (CGRectContainsPoint(itemOne, tapPoint)) { // one
        [self.delegate tableView:self didSelectColumn:self.currentPageIndex withItem:0];
    }else if (CGRectContainsPoint(itemTwo, tapPoint)){
         [self.delegate tableView:self didSelectColumn:self.currentPageIndex withItem:1];
    }else if (CGRectContainsPoint(itemThree, tapPoint)){
         [self.delegate tableView:self didSelectColumn:self.currentPageIndex withItem:2];
    }else if (CGRectContainsPoint(itemFour, tapPoint)){
         [self.delegate tableView:self didSelectColumn:self.currentPageIndex withItem:3];
    }
}

@end
