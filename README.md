# CDZPicker

This is a small Picker easy to use. The datas can be linkage.(For example country - city)

## Demo Preview

To be update

## Changelog

- Add unlinkage mode

## Installation

### Manual

Add "CDZPicker" files to your project

### CocoaPods

Add ``pod 'CDZPicker'`` in your Podfile

## Usage

``#import "CDZPicker.h"``

- Use single style

```objective-c
[CDZPicker showPickerInView:self.view withStrings:@[@"0",@"1",@"2"]//your string array confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = stringArray.firstObject;//your code
    } cancel:
    	//your code
    ];
```

* Use multi&unlinkage style

```objective-c
[CDZPicker showPickerInView:self.view withStringArrays:@[@[@"0",@"1",@"2"],@[@"0",@"1",@"2",@"3"]]//your string array's array
 confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@","];//your code
    } cancel:
   		//your code
];
```

- Use multi&linkage style

```objective-c
CDZPickerComponentObject *obj0 = [[CDZPickerComponentObject alloc]init];
    obj0.text = @"0";
    
CDZPickerComponentObject *obj00 = [[CDZPickerComponentObject alloc]init];
    obj00.text = @"00";

[obj0.subArray addObject:obj00];

    [CDZPicker showPickerInView:self.view withComponents:@[obj0]//your componet array
     confirm:^(NSArray<NSString *> *stringArray) {
        self.label.text = [stringArray componentsJoinedByString:@","];//your code
    } cancel:
     	//your code
    ];


```

## Articles

[iOS中封装一个自定义UIPickerView（Button篇）](http://www.jianshu.com/p/bf7f304ee308)

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

