//
//  CDZPicker.h
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2016/11/18.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDZPickerComponentObject.h"

typedef void (^CDZCancelBlock)(void);
typedef void (^CDZConfirmBlock)(NSArray<NSString *> *stringArray);

@interface CDZPicker : UIView


/**
 多行联动数据

 @param view 所在的view
 @param componentArray 传入componetobject数组，可嵌套
 @param confirmBlock 点击确认后
 @param cancelBlcok 点击取消后
 */

+ (void)showPickerInView:(UIView *)view
          withComponents:(NSArray<CDZPickerComponentObject *> *)componentArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok;

/**
 单行数据
 
 @param view 所在view
 @param stringArray 单个string数组
 @param confirmBlock 点击确认后
 @param cancelBlcok 点击取消后
 */

+ (void)showPickerInView:(UIView *)view
             withStrings:(NSArray<NSString *> *)stringArray
                 confirm:(CDZConfirmBlock)confirmBlock
                 cancel:(CDZCancelBlock)cancelBlcok;

/**
 多行不联动数据

 @param view 所在view
 @param arrays 二维数组，数组里string数组个数为行数，互相独立
 @param confirmBlock 点击确认后
 @param cancelBlcok 点击取消后
 */

+ (void)showPickerInView:(UIView *)view
        withStringArrays:(NSArray<NSArray <NSString*> *> *)arrays
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok;

@end
