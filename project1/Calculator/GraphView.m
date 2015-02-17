//
//  GraphView.m
//  Calculator
//
//  Created by Kelly Masuda on 2/7/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@implementation GraphView
@synthesize scale = _scale;
@synthesize origin = _origin;
@synthesize dataSource = _dataSource;

-(id) initWithFrame:(CGRect)frame{
    

    self = [super initWithFrame:frame];
    if (self){
        self.contentMode = UIViewContentModeRedraw;
    }
    return self;
}
-(void) setDataSource:(id<GraphViewDataSource>) newSource
{
    if (newSource == self.dataSource) return;
    _dataSource = newSource;
    
}
- (void) setOrigin:(CGPoint) axisOrigin
{
    if ((self.origin.x == axisOrigin.x)&&(self.origin.y == axisOrigin.y)) return;
    _origin = axisOrigin;
}

- (void) drawRect: (CGRect) rect
{
    if (!self.scale)
        self.scale = 50;
    if ((self.origin.x == 0)&&(self.origin.y == 0))
        self.origin = CGPointMake(rect.size.width/2,rect.size.height/2);
    
    int subPoints = rect.size.width*10;
    
    float leftX = -(rect.size.width-self.origin.x)/(self.scale);
    float dX = (rect.size.width/(self.scale*subPoints));
    //pixels per number
    
    //float pixelsPerNumber = rect.size.width/(2*self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Set the line width and colour of the axis.
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
    // Draw the axes using the AxesDrawer helper class.
    [AxesDrawer drawAxesInRect:self.bounds originAtPoint:self.origin scale:self.scale];
    
    [[UIColor blueColor] setFill];
    for (int subPoint = 0; subPoint < subPoints; subPoint++){
        CGPoint dataVal;
        dataVal.x = leftX + (dX*subPoint);
        dataVal.y = [self calcValue: (dataVal.x)];
        
        float drawX = self.origin.x+(dataVal.x*self.scale);
        float drawY = self.origin.y-(dataVal.y*self.scale);
        
        CGContextFillRect(context, CGRectMake(drawX, drawY, 1, 1));
        
    }

    
    [[UIColor blueColor] setStroke];
    CGContextSetLineWidth(context, 2.0);
    CGContextDrawPath(context, kCGPathEOFill);
}
- (float) calcValue:(float) xValue
{
    float Yval = [self.dataSource YValueForXValue: xValue];//
    //float Yval = (xValue * xValue * xValue) - (xValue*xValue);
    return Yval;
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        
        // TODO: Adjust the scale and reset the gesture scale to 1
        self.scale = self.scale * gesture.scale;
        gesture.scale = 1;
        
        
        [self setNeedsDisplay];
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        
        
        // Todo: Move the origin of the graph
        self.origin = CGPointMake(self.origin.x + [gesture translationInView: self].x, self.origin.y + [gesture translationInView: self].y);
        
        [self setNeedsDisplay];
    }
}
- (void)tripleTap:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.origin = [gesture locationOfTouch:0 inView:self];
    }
}


@end