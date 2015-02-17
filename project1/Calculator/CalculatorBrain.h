//
//  CalculatorBrain.h
//  Calculator
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (readonly) id program;

- (void)pushOperand:(double)operand;
- (void)pushToStack:(NSString *) variable;
- (double)performOperation:(NSString *)operation;

+ (NSString *)descriptionOfProgram:(id)program;

-(double)runProgram:(double)valX;
//+ (id)runProgram:(id)program
//usingVariableValues:(NSDictionary *)variableValue;

@end