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
@property (nonatomic, assign) NSInteger numberOfComponents;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray<CDZPickerComponentObject *> *componetArray;
@property (nonatomic, copy) CDZConfirmBlock confirmBlock;
@property (nonatomic, copy) CDZCancelBlock cancelBlock;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation CDZPicker

#pragma mark - setup

- (void)config{
    _numberOfComponents = [self numberOFComponents];
    _dataArray = [NSMutableArray array];
    for (NSInteger index = 0; index < _numberOfComponents; index++) {
        [_dataArray addObject:@(0)];
    }
    [self setupViews];
}

+ (void)showPickerInView:(UIView *)view
          withComponents:(NSArray<CDZPickerComponentObject *> *)componentArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.frame];
    pickerView.componetArray = componentArray;
    pickerView.confirmBlock = confirmBlock;
    pickerView.cancelBlock = cancelBlcok;
    [pickerView config];
    [view addSubview:pickerView];
}




+ (void)showPickerInView:(UIView *)view
              withString:(NSArray<NSString *> *)stringArray
                 confirm:(CDZConfirmBlock)confirmBlock
                  cancel:(CDZCancelBlock)cancelBlcok{
    CDZPicker *pickerView = [[CDZPicker alloc]initWithFrame:view.frame];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSString *string in stringArray) {
        CDZPickerComponentObject *object = [[CDZPickerComponentObject alloc]init];
        object.text = string;
        [arrayM addObject:object];
    }
    pickerView.componetArray = [arrayM copy];
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
    NSMutableArray<NSString *> *arrayM = [NSMutableArray array];
    NSInteger indexRow = [self.dataArray[0] integerValue];
    CDZPickerComponentObject *object = self.componetArray[indexRow];
    if (object.text.length > 0) {
        [arrayM addObject:object.text];
    }
    for (NSInteger index = 1; index < _numberOfComponents; index++) {
        indexRow = [self.dataArray[index] integerValue];
        object = [self objectAtIndex:indexRow inObject:object];
        if (object.text.length > 0) {
            [arrayM addObject:object.text];
        }
    }
    return [arrayM copy];
}

- (CDZPickerComponentObject *)objectAtIndex:(NSInteger)index inObject:(CDZPickerComponentObject *)object{
    if (object.subArray.count > index) {
        return object.subArray[index];
    }
    return nil;
}

- (NSInteger)numberOFComponents{
    NSInteger index;
    CDZPickerComponentObject *object = self.componetArray.firstObject;
    for (index = 1;; index++) {
        object = [self objectAtIndex:0 inObject:object];
        if (!object) {
            break;
        }
    }
    return index;
}

#pragma mark - PickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return _numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.componetArray.count;
    }
    else{
        NSInteger indexRow = [self.dataArray[0] integerValue];
        CDZPickerComponentObject *object = self.componetArray[indexRow];
        for (NSInteger index = 1; index < component; index++) {
            indexRow = [self.dataArray[index] integerValue];
            object = [self objectAtIndex:indexRow inObject:object];
        }
        return object.subArray.count;
    }
}

#pragma mark - PickerDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.dataArray setObject:@(row) atIndexedSubscript:component];
    if (component < (_numberOfComponents - 1)) {
        [self pickerView:pickerView didSelectRow:0 inComponent:component + 1];
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
    
    CDZPickerComponentObject *object;
    if (component == 0) {
        object = self.componetArray[row];
    }
    else{
        NSInteger indexRow = [self.dataArray[0] integerValue];
        object = self.componetArray[indexRow];
        for (NSInteger index = 1; index <= component; index++) {
            if (index == component) {
                object = [self objectAtIndex:row inObject:object];
            }
            else{
                indexRow = [self.dataArray[index] integerValue];
                object = [self objectAtIndex:indexRow inObject:object];
            }
        }
    }
    genderLabel.text = object.text;
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

