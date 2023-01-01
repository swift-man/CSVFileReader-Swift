# CSVFileReader-Swift

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
