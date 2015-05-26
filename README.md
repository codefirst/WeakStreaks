# WeakStreaks

## ビルド方法

### CocoaPodsの導入

```
$ sudo gem install cocoapods
```

### ソースコードの取得
```
$ git clone https://github.com/codefirst/WeakStreaks.git
$ cd FlickSKK
```

### 設定ファイルの書き換え
以下のようにConfig.xcconfigを作成し、適当な内容に書き換えてください。
特に `APP_IDENTIFIER` を自分のDeveloper ProgramのApp IDへの書き換えは必須です。

```
$ cp Config.xcconfig.example Config.xcconfig
```

### ビルド

```
$ pod install
```

その後、 WeakStreaks.*xcworkspace* を開いてビルドしてください。 (注: WeakStreaks.*xcodeproj* ではない)


## License
### Icon

 * AppIcon is created by http://icooon-mono.com/
