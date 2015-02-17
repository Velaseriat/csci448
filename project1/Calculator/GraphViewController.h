//
//  GraphicsViewController.h
//  Calculator
//
//  Created by Kelly Masuda on 2/7/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "GraphView.h"


@interface GraphViewController : UIViewController

- (void) generateGraph: (CalculatorBrain*) newBrain;
- (void) setGraphView:(GraphView *)graphView;

@end