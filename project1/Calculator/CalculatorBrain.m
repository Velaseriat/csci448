//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Kelly Masuda on 1/15/15.
//  Copyright (c) 2015 Kelly Masuda. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;


- (NSMutableArray *)operandStack
{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

- (void)pushOperand:(double)operand
{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

- (double)popOperand
{
    NSNumber *operandObject;
    operandObject = [self.operandStack lastObject];
    
    
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}

- (void)pushToStack:(NSString *) toStack{
    [self.operandStack addObject:toStack];
}

+ (NSString *)descriptionOfProgram:(id)program{
        return @"this is a function... that does things";
}

- (double)performOperation:(NSString *)operation
{
    double result = 0;
    
    if ([operation isEqualToString:@"+"]){
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"Pi"]) {
        result = M_PI;
    } else if ([operation isEqualToString:@"sin"]) {
        result = sin([self popOperand]*(M_PI));
    } else if ([operation isEqualToString:@"cos"]) {
        result = cos([self popOperand]*(M_PI));
    } else if ([operation isEqualToString:@"sqrt"]) {
        result = sqrt([self popOperand]);
    }
    
    [self pushOperand:result];
    
    if (result < 0.000000000000001){
        result = 0;
    }
    
    return result;
}

-(double) runProgram:(double) valX
{
    
    NSMutableArray *copiedStack = [[NSMutableArray alloc] initWithArray: self.operandStack copyItems:YES];
    //NSMutableArray *copiedStack2 = [[NSMutableArray alloc] initWithArray: self.operandStack copyItems:YES];
    
    [self.operandStack removeAllObjects];
    for (int x = 0; x < copiedStack.count; x++){
        id obj = [copiedStack objectAtIndex:x];
        //If it's a string, either it's an x variable or an operator
        if ([obj isKindOfClass:[NSString class]]){
            if ([(NSString *) obj isEqualToString: @"x"]){
                [self pushOperand:valX];
            }else{
                //evaluate operation using perform operation
                [self performOperation:((NSString *) obj)];
            }
            
        }else{
            //pushes number into stack
            double num = [obj doubleValue];
            [self pushOperand:num];
        }
    }
    
    double result = [[self.operandStack lastObject] doubleValue];
    self.operandStack = copiedStack;
    return result;
}
@end