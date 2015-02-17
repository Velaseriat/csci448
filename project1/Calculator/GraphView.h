//
//  GraphView.h
//  Calculator
//
//  Created by Kelly Masuda on 2/7/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GraphView;

@protocol GraphViewDataSource
-(float) YValueForXValue:(float)xValue;
@end


@interface GraphView : UIView

@property (nonatomic, weak) IBOutlet id <GraphViewDataSource> dataSource;
@property (nonatomic) float scale;
@property (nonatomic) CGPoint origin;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;
- (void)pan:(UIPanGestureRecognizer *)gesture;
- (void)tripleTap:(UITapGestureRecognizer *)gesture;

@end