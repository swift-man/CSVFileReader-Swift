# CSVFileReader-Swift

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge - Version](https://img.shields.io/badge/Version-0.5.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac|ios|watchos|tvos-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)

## Load
```swift
let reader = CSVFileReader()
let array: [NIADicDecodeSample] = try reader.load(filename: "NIADic") // Decodable Array
```

```swift
let reader = CSVFileReader()
let array: [[String]] = try reader.load(filename: "Number") // String Array
```

```swift
let reader = CSVFileReader()
let data: Data = try reader.data(filename: "NIADic") // Data
```

## hasHeaderRow
첫번째 컬럼의 데이터 포함 여부, 기본값 : true
```swift
let reader = CSVFileReader()
let array: [NIADicDecodeSample] = try reader.load(filename: "NIADic", hasHeaderRow: false)
```
