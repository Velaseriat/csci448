//
//  ViewController.m
//  Calculator
//
//  Created by Kelly Masuda on 1/15/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"
#import "GraphViewController.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userEnteredDecimal;
@property (nonatomic) BOOL shouldNotEvaluate;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize operationsDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userEnteredDecimal;
@synthesize shouldNotEvaluate;
@synthesize brain = _brain;

- (CalculatorBrain *)brain{
    if (! _brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}
- (IBAction)xPressed {
    [self.brain pushToStack:@"x"];
    self.display.text = @"x";
    [self editOperationsDisplay:@"x" andEvaluate:NO];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.shouldNotEvaluate = YES;
}

- (IBAction)decimalPressed {
    if (! self.userEnteredDecimal){
        self.display.text = [self.display.text stringByAppendingString:@"."];
        self.userEnteredDecimal = YES;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    if (shouldNotEvaluate){
        [self.brain pushToStack:operation];
    }
    else {
        double result = [self.brain performOperation:operation];
        self.display.text = [NSString stringWithFormat:@"%g", result];
    }
    
    if (! [operation isEqualToString:@"Pi"]) {
        [self editOperationsDisplay:operation andEvaluate:YES];
    } else {
        self.userIsInTheMiddleOfEnteringANumber = YES;
        [self enterPressed];
    }
}

- (IBAction)deletePressed {
    self.display.text = @"0";
}

- (IBAction)toggleNeg {
    double value = [self.display.text doubleValue];
    value *= (-1);
    self.display.text = [@(value) stringValue];
}

- (IBAction)testFunction:(id)sender {
    
    double num = [self.brain runProgram:(5.0)];
    self.display.text = [@(num) stringValue];
}


- (IBAction)enterPressed {
    if (![self.display.text isEqualToString: @"x"])
        [self.brain pushOperand:[self.display.text doubleValue]];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self editOperationsDisplay:self.display.text andEvaluate:NO];
    }
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userEnteredDecimal = NO;
}

- (void)editOperationsDisplay:(NSString *)data andEvaluate:(BOOL)evaluate {
    self.operationsDisplay.text = [self.operationsDisplay.text stringByAppendingString:@" "];
    self.operationsDisplay.text = [self.operationsDisplay.text stringByAppendingString:data];
    if (evaluate){
        self.operationsDisplay.text = [self.operationsDisplay.text stringByAppendingString:@"="];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    GraphViewController *gvc = [segue destinationViewController];
    [gvc setGraphView:[[GraphView alloc] init]];

    [segue.destinationViewController generateGraph: self.brain];
}

- (IBAction)clearAll {
    self.operationsDisplay.text = @"";
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userEnteredDecimal = NO;
    self.shouldNotEvaluate = NO;
    _brain = [[CalculatorBrain alloc] init];
}
@end