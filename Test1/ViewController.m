//
//  ViewController.m
//  Test1
//
//  Created by Andrey Kindyaev on 5/2/16.
//  Copyright © 2016 ScienceSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.text = @"3 1 -5 3 3 -5 0 10 1 1";
}

#pragma mark - Actions
- (IBAction)onSolve:(id)sender {
    NSArray *stringNumbers = [self.textField.text componentsSeparatedByString:@" "];
    NSMutableArray *numbers = [NSMutableArray arrayWithCapacity:stringNumbers.count];
    for (NSString *string in stringNumbers) {
        // assuming that the data in the string are correct
        [numbers addObject:@(string.integerValue)];
    }
    self.label.text = [self _resultStringWithNumbers:numbers];
}

#pragma mark - Private
- (NSString *)_resultStringWithNumbers:(NSArray *)numbers {
    NSMutableString *resultString = [NSMutableString new];
    NSUInteger count = numbers.count;
    if (count == 0) {
        [resultString appendString:@"Empty array"];
    } else {
        NSNumber *minNumber = [numbers firstObject];
        NSNumber *maxNumber = minNumber;
        // dictionary: key - number, value - count
        NSMutableDictionary *countByNumber = [NSMutableDictionary dictionaryWithCapacity:count];
        [self _addNumber:minNumber toCountDictionary:countByNumber];
        if (count > 1) {
            // skip first element
            for (NSInteger index = 1; index < count; index ++) {
                NSNumber *number = numbers[index];
                if ([number compare:minNumber] == NSOrderedAscending) {
                    minNumber = number;
                }
                if ([number compare:maxNumber] == NSOrderedDescending) {
                    maxNumber = number;
                }
                [self _addNumber:number toCountDictionary:countByNumber];
            }
        }
        [resultString appendFormat:@"%@\n%@\n%@",
         [self _rangeStringWithMin:minNumber max:maxNumber],
         [self _missingNumbersWithCountDictionary:countByNumber min:minNumber max:maxNumber],
         [self _duplicateNumbersWithCountDictionary:countByNumber]];
    }
    return resultString;
}

- (NSString *)_rangeStringWithMin:(NSNumber *)min max:(NSNumber *)max {
    return [NSString stringWithFormat:@"Range is %@ to %@", min, max];
}

- (NSString *)_missingNumbersWithCountDictionary:(NSDictionary *)countDictionary
                                             min:(NSNumber *)min
                                             max:(NSNumber *)max {
    NSMutableString *resultString = [NSMutableString stringWithString:@"Missing numbers:"];
    BOOL hasMissing = NO;
    if (nil != countDictionary) {
        NSInteger maxValue = max.integerValue;
        for (NSInteger value = min.integerValue; value < maxValue; value++) {
            NSNumber *numberValue = @(value);
            if (nil == countDictionary[numberValue]) {
                hasMissing = YES;
                [resultString appendFormat:@"\n %@", numberValue];
            }
        }
    }
    if (!hasMissing) {
        [resultString appendFormat:@"\nNo"];
    }
    return resultString;
}

- (NSString *)_duplicateNumbersWithCountDictionary:(NSDictionary *)countDictionary {
    NSMutableString *resultString = [NSMutableString stringWithString:@"Duplicate numbers:"];
    BOOL hasDuplicate = NO;
    if (nil != countDictionary) {
        for (NSNumber *number in countDictionary) {
            NSNumber *count = countDictionary[number];
            if (count.integerValue > 1) {
                hasDuplicate = YES;
                [resultString appendFormat:@"\n %@ appears %@ times", number, count];
            }
        }
    }
    if (!hasDuplicate) {
        [resultString appendFormat:@"\nNo"];
    }
    return resultString;
}

// if countDictionary contains number (key) then increase count (value) by 1
// if no - add number (key) with count (value) 1
- (void)_addNumber:(NSNumber *)number toCountDictionary:(NSMutableDictionary *)countDictionary {
    NSNumber *countNumber = countDictionary[number];
    NSInteger count = 1;
    if (nil != countNumber) {
        count = countNumber.integerValue + 1;
    }
    countDictionary[number] = @(count);
}

@end
