//
//  CSVFileReader.swift
//  CSVFileReader
//
//  Created by SwiftMan on 2023/01/01.
//

import Foundation

public final class CSVFileReader {
  public func data(bundle: Bundle = Bundle.main, filename: String) throws -> Data {
    guard
      let url = bundle.url(forResource: filename, withExtension: "csv")
    else { throw CSVFileReaderError.invalidFileURL }
    
    return try Data(contentsOf: url)
  }
  
  public func load(bundle: Bundle = Bundle.main,
                   filename: String,
                   encoding: String.Encoding = .utf8,
                   hasHeaderRow: Bool = true) throws -> [[String]] {
    let data: Data = try data(bundle: bundle, filename: filename)
    
    return try _parseStringArray(data: data,
                                 encoding: encoding,
                                 hasHeaderRow: hasHeaderRow)
  }
  
  public func load<T: Decodable>(bundle: Bundle = Bundle.main,
                                 filename: String,
                                 encoding: String.Encoding = .utf8,
                                 hasHeaderRow: Bool = true) throws -> [T] {
    var parsedStringArray: [[String]] = try load(bundle: bundle,
                                                 filename: filename,
                                                 hasHeaderRow: true)
    
    let keys = try _extractKeys(parsedStringArray: &parsedStringArray)
    
    var decodedArray: [T] = try _decodeJson(parsedStringArray: parsedStringArray, keys: keys)
    
    if !hasHeaderRow {
      if !decodedArray.isEmpty {
        decodedArray.remove(at: 0)
      }
    }
    
    return decodedArray
  }
  
  private func _parseStringArray(data: Data,
                                 encoding: String.Encoding,
                                 hasHeaderRow: Bool) throws -> [[String]] {
    guard
      let dataEncoded = String(data: data, encoding: encoding)
    else { throw CSVFileReaderError.invalidDataEncoding }
    
    let separator: String
    if dataEncoded.last == "\r\n" {
      separator = "\r\n"
    } else {
      separator = "\n"
    }
    
    var dimensionalStringArray = dataEncoded.components(separatedBy: separator)
      .map { $0.components(separatedBy: ",") }
      
    if !hasHeaderRow {
      if !dimensionalStringArray.isEmpty {
        dimensionalStringArray.remove(at: 0)
      }
    }
    
    return dimensionalStringArray
  }
  
  private func _extractKeys(parsedStringArray: inout [[String]]) throws -> [String] {
    guard let first = parsedStringArray.first else { throw CSVFileReaderError.keyNotFound }
    parsedStringArray.remove(at: 0)
    return first
  }
  
  private func _decodeJson<T: Decodable>(parsedStringArray: [[String]], keys: [String]) throws -> [T] {
    var result: [T] = []
    let decoder = JSONDecoder()
    for csvRowArray in parsedStringArray where !csvRowArray.isEmpty && csvRowArray.count == keys.count {
      var dic: [String: String] = [:]
      for (index, key) in keys.enumerated() {
        dic[key] = csvRowArray[index]
      }
      
      let data = try JSONSerialization.data(withJSONObject: dic,
                                  options: [.prettyPrinted])
      do {
        let decoded = try decoder.decode(T.self, from: data)
        result.append(decoded)
      } catch {
        throw error
      }
    }
    return result
  }
}
