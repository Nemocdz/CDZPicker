//
//  CDZPicker.m
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2016/11/18.
//  Copyright © 2016年 Nemocdz. All rights reserved.

#import "CDZPicker.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define BACKGROUND_BLACK_COLOR [UIColor colorWithRed:0.412 green:0.412 blue:0.412 alpha:0.7]
static const int pickerViewHeight = 228;
static const int toolBarHeight = 44;

@interface CDZPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSString *lastString;
@property (nonatomic,  copy) CDZStringResultBlock block;
@end

@implementation CDZPicker

#pragma mark - AboutInit
+ (void)showPickerInView:(UIView *)view
        withObjectsArray:(NSArray *)array
          withlastString:(NSString *)string
         withStringBlock:(CDZStringResultBlock)stringBlock{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.bounds];
    pickerView.dataArray = array;
    pickerView.lastString = string;
    pickerView.block = stringBlock;
    pickerView.block(array[0]);//未滑动默认为第一个数值
    [pickerView initView];
    [view addSubview:pickerView];
}


- (void)initView{
    UIView *containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickerViewHeight, SCREEN_WIDTH, pickerViewHeight)];
    containerView.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnOK = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -70, 5, 40, 30)];
    btnOK.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnOK setTitle:@"确定" forState:UIControlStateNormal];
    [btnOK setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnOK addTarget:self action:@selector(pickerViewBtnOk:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnOK];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(30, 5, 40, 30)];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(pickerViewBtnCancel:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:btnCancel];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, pickerViewHeight - toolBarHeight)];
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containerView addSubview:pickerView];
    
    self.backgroundColor = BACKGROUND_BLACK_COLOR;
    [self addSubview:containerView];
}

- (void)dealloc {
    NSLog(@"dealloc: %@", [[self class]description]);
}

#pragma mark - event response
- (void)pickerViewBtnOk:(UIButton *)btn{
    [self removeFromSuperview];
}

- (void)pickerViewBtnCancel:(UIButton *)btn{
    self.block (self.lastString);
    [self removeFromSuperview];
}

#pragma mark - PickerDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

#pragma mark - PickerDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.block(self.dataArray[row]);
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = [UIColor clearColor];
        }
    }
    //设置文字的属性
    UILabel *genderLabel = [UILabel new];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.text = self.dataArray[row];
    genderLabel.font = [UIFont systemFontOfSize:23.0];
    genderLabel.textColor = [UIColor blackColor];
    
    return genderLabel;
}


@end

