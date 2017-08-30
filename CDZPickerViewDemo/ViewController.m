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
- (IBAction)multiNotLink:(UIButton *)sender;
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
    CDZPickerBuilder *builder = [CDZPickerBuilder new];
    builder.showMask = YES;
    builder.cancelTextColor = UIColor.redColor;
    [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:@[@"objective-c",@"java",@"python",@"php"] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = strings.firstObject;
        NSLog(@"strings:%@ indexs:%@",strings,indexs);
    }cancel:^{
        //your code
    }];
}


- (IBAction)multiNotLink:(UIButton *)sender {
    [CDZPicker showMultiPickerInView:self.view withBuilder:nil stringArrays:@[@[@"MacOS",@"Windows",@"Linux",@"Ubuntu"],@[@"Xcode",@"VSCode",@"Sublime",@"Atom"]] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = [strings componentsJoinedByString:@"+"];
        NSLog(@"strings:%@ indexs:%@",strings,indexs);
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
    
    [CDZPicker showLinkagePickerInView:self.view withBuilder:nil components:@[guangdong,sichuan] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = [strings componentsJoinedByString:@","];
        NSLog(@"strings:%@ indexs:%@",strings,indexs);
    }cancel:^{
        //your code
    }];

}
@end
