//
//  GraphViewController.m
//  Calculator
//
//  Created by Kelly Masuda on 2/7/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//


#import "GraphViewController.h"


@interface GraphViewController() <GraphViewDataSource>
@property (nonatomic, strong) CalculatorBrain *brain;
@property (strong, nonatomic) IBOutlet GraphView *graphView;

@end


@implementation GraphViewController

@synthesize brain = _brain;
@synthesize graphView = _graphView;


-(void) generateGraph: (CalculatorBrain*) newBrain{
    self.brain = newBrain;
}

-(float) YValueForXValue:(float)xValue {
    return [self.brain runProgram:xValue];
}

- (void) setGraphView:(GraphView *)graphView {
    _graphView = graphView;
    self.graphView.dataSource = self;
    
    // enable pinch gesture in the GraphView using pinch: handler
    [self.graphView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                          initWithTarget:self.graphView
                                          action:@selector(pinch:)]];
    
    // enable pan gesture in the GraphView using pan: handler
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                          initWithTarget:self.graphView
                                          action:@selector(pan:)]];
    
    // enable triple tap gesture in the GraphView using tripleTap: handler
    UITapGestureRecognizer *tapGestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self.graphView
                                            action:@selector(tripleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 3;
    [self.graphView addGestureRecognizer:tapGestureRecognizer];
    
    // We want to update the graphView to set the starting values for the program. In iPad mode
    // this method is called before a program is set, in which case we don't want to do anything
    self.graphView.dataSource = self;
    [self refreshView];
}

- (void)refreshView {

    // Refresh the graph View
    [self.graphView setNeedsDisplay];
    
}

- (void)viewDidLoad
{
    [self setGraphView:[[GraphView alloc] init]];
}

@end