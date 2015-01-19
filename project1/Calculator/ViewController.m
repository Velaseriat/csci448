//
//  ViewController.m
//  Calculator
//
//  Created by Kelly Masuda on 1/15/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userEnteredDecimal;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize operationsDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize userEnteredDecimal;
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
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
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



- (IBAction)enterPressed {
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

- (IBAction)clearAll {
    self.operationsDisplay.text = @"";
    self.display.text = @"0";
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.userEnteredDecimal = NO;
    _brain = [[CalculatorBrain alloc] init];
}
@end