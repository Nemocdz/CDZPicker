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


+ (void)showPickerInView:(UIView *)view
          withComponents:(NSArray<CDZPickerComponentObject *> *)componentArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok;

+ (void)showPickerInView:(UIView *)view
              withString:(NSArray<NSString *> *)stringArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok;

@end
