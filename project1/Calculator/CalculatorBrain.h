//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Kelly Masuda on 1/15/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
