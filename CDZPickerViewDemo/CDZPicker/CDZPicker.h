//
//  CDZPicker.h
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2016/11/18.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CDZStringResultBlock)(NSString *string);

@interface CDZPicker : UIView
+ (void)showPickerInView:(UIView *)view
        withObjectsArray:(NSArray *)array
          withlastString:(NSString *)string
         withStringBlock:(CDZStringResultBlock)stringBlock;

@end
