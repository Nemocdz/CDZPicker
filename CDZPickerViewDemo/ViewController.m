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
- (IBAction)showPicker:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)showPicker:(UIButton *)sender {
    NSArray *array = @[@"电子科技大学",@"清华大学",@"四川大学",@"华中科技大学",@"西安电子科技大学"];
    [CDZPicker showPickerInView:self.view withObjectsArray:array withlastString:self.label.text withStringBlock:^(NSString *string) {
        self.label.text = string;
    }];
}
@end
