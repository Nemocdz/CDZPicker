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
static const int pickerViewHeight = 248;
static const int toolBarHeight = 44;

@interface CDZPicker()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) BOOL isLinkage;
@property (nonatomic, assign) NSInteger numberOfComponents;

@property (nonatomic, strong) NSArray<CDZPickerComponentObject *> *componetArray;
@property (nonatomic, copy) CDZConfirmBlock confirmBlock;
@property (nonatomic, copy) CDZCancelBlock cancelBlock;

@property (nonatomic, strong) NSArray<NSArray <NSString*> *> *stringArrays;

@property (nonatomic, strong) NSMutableArray<NSMutableArray <CDZPickerComponentObject *> *> *rowsArray;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation CDZPicker

#pragma mark - setup

- (void)config{
    if (!_isLinkage) {
        _numberOfComponents = self.stringArrays.count;
    }
    else{
        _rowsArray = [NSMutableArray array];
        CDZPickerComponentObject *object = self.componetArray.firstObject;
        [_rowsArray setObject:[NSMutableArray arrayWithArray:self.componetArray] atIndexedSubscript:0];
        for (_numberOfComponents = 1;; _numberOfComponents++) {
            [_rowsArray setObject:object.subArray atIndexedSubscript:_numberOfComponents];
            object = [self objectAtIndex:0 inObject:object];
            if (!object) {
                break;
            }
        }
    }
    [self setupViews];
}



+ (void)showPickerInView:(UIView *)view
          withComponents:(NSArray<CDZPickerComponentObject *> *)componentArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.frame];
    pickerView.isLinkage = YES;
    pickerView.componetArray = componentArray;
    pickerView.confirmBlock = confirmBlock;
    pickerView.cancelBlock = cancelBlcok;
    [pickerView config];
    [view addSubview:pickerView];
}




+ (void)showPickerInView:(UIView *)view
             withStrings:(NSArray<NSString *> *)stringArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.frame];
    
    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:stringArray.count];
    for (NSString *string in stringArray) {
        CDZPickerComponentObject *object = [[CDZPickerComponentObject alloc]initWithText:string];
        [tmp addObject:object];
    }
    
    pickerView.isLinkage = YES;
    pickerView.componetArray = [tmp copy];
    pickerView.confirmBlock = confirmBlock;
    pickerView.cancelBlock = cancelBlcok;
    [pickerView config];
    [view addSubview:pickerView];
}


+ (void)showPickerInView:(UIView *)view
        withStringArrays:(NSArray<NSArray<NSString *> *> *)arrays
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.frame];
    pickerView.isLinkage = NO;
    pickerView.stringArrays = arrays;
    pickerView.confirmBlock = confirmBlock;
    pickerView.cancelBlock = cancelBlcok;
    [pickerView config];
    [view addSubview:pickerView];
}



- (void)setupViews{
    self.backgroundColor = BACKGROUND_BLACK_COLOR;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissView)];
    [self addGestureRecognizer:tap];
    [self addSubview:self.containerView];
    
    [self.containerView addSubview:self.pickerView];
    [self.containerView addSubview:self.confirmButton];
    [self.containerView addSubview:self.cancelButton];
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
}


#pragma mark - event response

- (void)confirm:(UIButton *)button{
    if (self.confirmBlock){
        self.confirmBlock([self resultStringArray]);
    }
    [self removeFromSuperview];
}

- (void)dissView{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];
}

- (void)cancel:(UIButton *)button{
    [self dissView];
}


#pragma mark - private

- (NSArray *)resultStringArray{
    NSMutableArray<NSString *> *resultArray = [NSMutableArray arrayWithCapacity:_numberOfComponents];
   
    if (!_isLinkage) {
        for (NSInteger index = 0; index < _numberOfComponents; index++) {
            NSInteger indexRow = [self.pickerView selectedRowInComponent:index];
            NSArray<NSString *> *tmp = self.stringArrays[index];
            if (tmp.count > 0) {
                [resultArray addObject:tmp[indexRow]];
            }
        }
    }
    else{
        for (NSInteger index = 0; index < _numberOfComponents; index++) {
            NSInteger indexRow = [self.pickerView selectedRowInComponent:index];
            NSMutableArray<CDZPickerComponentObject *> *tmp = self.rowsArray[index];
            if (tmp.count > 0) {
                [resultArray addObject:tmp[indexRow].text];
            }
        }
    }
    return [resultArray copy];
}

- (CDZPickerComponentObject *)objectAtIndex:(NSInteger)index inObject:(CDZPickerComponentObject *)object{
    if (object.subArray.count > index) {
        return object.subArray[index];
    }
    return nil;
}


#pragma mark - PickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (!_isLinkage) {
        return self.stringArrays[component].count;
    }
    else{
        return self.rowsArray[component].count;
    }
}



#pragma mark - PickerDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (!_isLinkage) {
        return;
    }
    
    if (component < (_numberOfComponents - 1)) {
        NSMutableArray<CDZPickerComponentObject *> *tmp = self.rowsArray[component];
        if (tmp.count > 0) {
            tmp = tmp[row].subArray;
        }
        [self.rowsArray setObject:((tmp.count > 0) ? tmp : [NSMutableArray array])  atIndexedSubscript:component + 1];
        
        [self pickerView:pickerView didSelectRow:0 inComponent:component + 1];
        [pickerView selectRow:0 inComponent:component + 1 animated:NO];
    }
    [pickerView reloadComponent:component];
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
    genderLabel.font = [UIFont systemFontOfSize:23.0];
    genderLabel.textColor = [UIColor blackColor];
    
    if (!_isLinkage) {
        NSArray<NSString *> *tmp = self.stringArrays[component];
        if (tmp.count > 0) {
            genderLabel.text = tmp[row];
        }
    }
    else{
        NSArray<CDZPickerComponentObject *> *tmp = self.rowsArray[component];
        if (tmp.count > 0) {
            genderLabel.text = tmp[row].text;
        }
    }
    return genderLabel;
}



#pragma mark - getter

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - pickerViewHeight, SCREEN_WIDTH, pickerViewHeight)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}



- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -70, 10, 40, 30)];
        _confirmButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, 40, 30)];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH, pickerViewHeight - toolBarHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


@end

