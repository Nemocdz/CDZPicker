//
//  ViewController.m
//  CDZPickerViewDemo
//
//  Created by Nemocdz on 2016/11/18.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "ViewController.h"
#import "CDZPicker.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)single:(UIButton *)sender;
- (IBAction)multiNotLInk:(UIButton *)sender;
- (IBAction)multiLink:(UIButton *)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showPicker:(UIButton *)sender {
    
}
- (IBAction)single:(UIButton *)sender {
    [CDZPicker showPickerInView:self.view withStrings:@[@"0",@"1",@"2"] confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = stringArray.firstObject;
    } cancel:nil];
}


- (IBAction)multiNotLInk:(UIButton *)sender {
    [CDZPicker showPickerInView:self.view withStringArrays:@[@[@"0",@"1",@"2"],@[@"0",@"1",@"2",@"3"]] confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@","];
    } cancel:nil];
}

- (IBAction)multiLink:(UIButton *)sender {
    CDZPickerComponentObject *obj0 = [[CDZPickerComponentObject alloc]init];
    obj0.text = @"0";
    
    CDZPickerComponentObject *obj00 = [[CDZPickerComponentObject alloc]init];
    obj00.text = @"00";
    
    CDZPickerComponentObject *obj01 = [[CDZPickerComponentObject alloc]init];
    obj01.text = @"01";
    
    CDZPickerComponentObject *obj000 = [[CDZPickerComponentObject alloc]init];
    obj000.text = @"000";
    
    CDZPickerComponentObject *obj001 = [[CDZPickerComponentObject alloc]init];
    obj001.text = @"001";
    
    CDZPickerComponentObject *obj0000 = [[CDZPickerComponentObject alloc]init];
    obj0000.text = @"0000";
    
    CDZPickerComponentObject *obj0001 = [[CDZPickerComponentObject alloc]init];
    obj0001.text = @"0001";
    
    CDZPickerComponentObject *obj1 = [[CDZPickerComponentObject alloc]init];
    obj1.text = @"1";
    
    CDZPickerComponentObject *obj10 = [[CDZPickerComponentObject alloc]init];
    obj10.text = @"10";
    
    CDZPickerComponentObject *obj100 = [[CDZPickerComponentObject alloc]init];
    obj100.text = @"100";
    
    CDZPickerComponentObject *obj101 = [[CDZPickerComponentObject alloc]init];
    obj101.text = @"101";
    
    [obj0.subArray addObject:obj00];
    [obj0.subArray addObject:obj01];
    
    [obj00.subArray addObject:obj000];
    [obj00.subArray addObject:obj001];
    
    [obj000.subArray addObject:obj0000];
    [obj000.subArray addObject:obj0001];
    
    [obj1.subArray addObject:obj10];
    [obj10.subArray addObject:obj100];
    [obj10.subArray addObject:obj101];
    
    NSArray *array = @[obj0,obj1];
    
    [CDZPicker showPickerInView:self.view withComponents:array confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@","];
    } cancel:nil];

}
@end
