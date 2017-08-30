# CDZPicker

This is a small Picker easy to use. The datas can be linkage.(For example country - city)

## Demo Preview

![](https://ww4.sinaimg.cn/large/006tNc79ly1fe330ca1zjg30ca0m8wil.gif)

## Changelog

- Fix Frame when superView is not corret frame
- Add builder to custom the picker
- Return Selected Indexs

## Installation

### Manual

Add "CDZPicker" files to your project

### CocoaPods

Add ``pod 'CDZPicker'`` in your Podfile

## Usage

``#import "CDZPicker.h"``

- Single:

```objective-c
[CDZPicker showSinglePickerInView:self.view withBuilder:nil strings:@[@"objective-c",@"java",@"python",@"php"] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = strings.firstObject;
    }cancel:^{
        //your code
    }];
```

- Multiple & Unlinkage：

```objective-c
 [CDZPicker showMultiPickerInView:self.view withBuilder:nil stringArrays:@[@[@"MacOS",@"Windows",@"Linux",@"Ubuntu"],@[@"Xcode",@"VSCode",@"Sublime",@"Atom"]] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = [strings componentsJoinedByString:@"+"];
    } cancel:^{
        // your code
    }];
```

- Multiple & Linkage：

  First config the objects and its subArray.

```objective-c
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
```

```objective-c
[CDZPicker showLinkagePickerInView:self.view withBuilder:nil components:@[guangdong,sichuan] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.label.text = [strings componentsJoinedByString:@","];
    }cancel:^{
        //your code
    }];
```

## Articles

[iOS中封装一个自定义UIPickerView（Button篇）](http://www.jianshu.com/p/bf7f304ee308)

[iOS中实现一个小巧的多列联动的PickerView](http://www.jianshu.com/p/ab35c440a352)

## Requirements

iOS 8.0 Above

## TODO

- Add config of labels.

## Contact

- Open a issue
- QQ：757765420
- Email：nemocdz@gmail.com
- Weibo：[@Nemocdz](http://weibo.com/nemocdz)

## License

CDZPicker is available under the MIT license. See the LICENSE file for more info.

