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
    [CDZPicker showPickerInView:self.view withStrings:@[@"objective-c",@"java",@"python",@"php"] confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = stringArray.firstObject;
    }cancel:^{
        //your code
    }];
}


- (IBAction)multiNotLInk:(UIButton *)sender {
    [CDZPicker showPickerInView:self.view withStringArrays:@[@[@"MacOS",@"Windows",@"Linux",@"Ubuntu"],@[@"Xcode",@"VSCode",@"Sublime",@"Atom"]] confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@"+"];
    } cancel:^{
        // your code
    }];
}

- (IBAction)multiLink:(UIButton *)sender {
    CDZPickerComponentObject *haizhu = [[CDZPickerComponentObject alloc]initWithText:@"海珠区"];
    CDZPickerComponentObject *yuexiu = [[CDZPickerComponentObject alloc]initWithText:@"越秀区"];
    
    CDZPickerComponentObject *guangzhou = [[CDZPickerComponentObject alloc]initWithText:@"广州市"];
    guangzhou.subArray = [NSMutableArray arrayWithObjects:haizhu,yuexiu, nil];
    
    CDZPickerComponentObject *xiangqiao = [[CDZPickerComponentObject alloc]initWithText:@"湘桥区"];
    CDZPickerComponentObject *chaozhou = [[CDZPickerComponentObject alloc]initWithText:@"潮州市"];
    chaozhou.subArray = [NSMutableArray arrayWithObjects:xiangqiao, nil];
    
    CDZPickerComponentObject *guangdong = [[CDZPickerComponentObject alloc]initWithText:@"广东省"];
    guangdong.subArray = [NSMutableArray arrayWithObjects:guangzhou,chaozhou, nil];
    
    CDZPickerComponentObject *pixian = [[CDZPickerComponentObject alloc]initWithText:@"郫县"];

    CDZPickerComponentObject *chengdu = [[CDZPickerComponentObject alloc]initWithText:@"成都市"];
    chengdu.subArray = [NSMutableArray arrayWithObjects:pixian, nil];
    
    CDZPickerComponentObject *leshan = [[CDZPickerComponentObject alloc]initWithText:@"乐山市"];
    
    CDZPickerComponentObject *sichuan = [[CDZPickerComponentObject alloc]initWithText:@"四川省"];
    sichuan.subArray = [NSMutableArray arrayWithObjects:chengdu,leshan, nil];
    
    [CDZPicker showPickerInView:self.view withComponents:@[guangdong,sichuan] confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@","];
    }cancel:^{
        //your code
    }];

}
@end
