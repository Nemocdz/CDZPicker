//
//  CDZPickerComponentObject.h
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2017/3/25.
//  Copyright © 2017年 Nemocdz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDZPickerComponentObject : NSObject

@property (nonatomic, strong) NSMutableArray<CDZPickerComponentObject *> *subArray;
@property (nonatomic, copy) NSString *text;

@end
