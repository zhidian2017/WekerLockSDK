# WekerLockSDK

[![CI Status](http://img.shields.io/travis/hduhky/WekerLockSDK.svg?style=flat)](https://travis-ci.org/hduhky/WekerLockSDK)
[![Version](https://img.shields.io/cocoapods/v/WekerLockSDK.svg?style=flat)](http://cocoapods.org/pods/WekerLockSDK)
[![License](https://img.shields.io/cocoapods/l/WekerLockSDK.svg?style=flat)](http://cocoapods.org/pods/WekerLockSDK)
[![Platform](https://img.shields.io/cocoapods/p/WekerLockSDK.svg?style=flat)](http://cocoapods.org/pods/WekerLockSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## 主要功能

* 绑定门锁
* 蓝牙开门
* 设置密码

## Installation

WekerLockSDK is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WekerLockSDK"
```

## 使用方法

* 在项目Target的Build Settings选项卡中， 找到Other Linker Flags，添加“-ObjC”选项，（如果已添加，则忽略此操作）
* 该SDK仅支持真机调试
* 编译工程，如果编译通过，恭喜你，集成 SDK 成功，可以进行下一步了，若报错，请联系我们进行协助
* `https://github.com/zhidian2017/WekerLockSDK`  该网址是SDK的Demo地址，可以作为参考

## 项目实战

* 在项目中合适的地方导入头文件 `import <WekerLockSDK/WLSdk.h>` ，其他具体操作详见SDK与Demo。

## Author

hduhky, 495751349@qq.com

## License

WekerLockSDK is available under the MIT license. See the LICENSE file for more info.
