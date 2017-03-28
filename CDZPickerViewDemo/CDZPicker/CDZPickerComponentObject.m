//
//  CDZPickerComponentObject.m
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2017/3/25.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import "CDZPickerComponentObject.h"

@implementation CDZPickerComponentObject
- (instancetype)init{
    return [self initWithText:@"" subArray:[NSMutableArray array]];
}

- (instancetype)initWithText:(NSString *)text{
    return [self initWithText:text subArray:[NSMutableArray array]];
}


- (instancetype)initWithText:(NSString *)text subArray:(NSMutableArray *)array{
    if (self = [super init]) {
        _text = text;
        _subArray = array;
    }
    return self;
}

@end
