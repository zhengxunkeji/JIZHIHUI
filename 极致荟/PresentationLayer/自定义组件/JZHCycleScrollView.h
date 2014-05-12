//
//  JZHCycleScrollView.h
//  极致荟
//
//  Created by mac on 14-4-8.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JZHCycleScrollViewDelegate;
@protocol JZHCycleScrollViewDatasource;

@interface JZHCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<JZHCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<JZHCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
@end

@protocol JZHCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(JZHCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol JZHCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages:(JZHCycleScrollView*)scrollView;
- (UIView *)XLScrollView:(JZHCycleScrollView*)scrollView pageAtIndex:(NSInteger)index;

@end
