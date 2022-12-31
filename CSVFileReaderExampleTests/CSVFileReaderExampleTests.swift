//
//  CSVFileReaderTests.swift
//  CSVFileReaderTests
//
//  Created by SwiftMan on 2023/01/01.
//

import XCTest
@testable import CSVFileReaderExample

class CSVFileReaderTests: XCTestCase {
  var reader = CSVFileReader()
  
  func testNIADicToData() {
    XCTAssertNoThrow(try reader.data(bundle: Bundle(for: CSVFileReader.self), filename: "NIADic"))
  }
  
  func testEmptyToData() {
    XCTAssertNoThrow(try reader.data(bundle: Bundle(for: CSVFileReader.self), filename: "Empty"))
  }
  
  func testNumberToData() {
    XCTAssertNoThrow(try reader.data(bundle: Bundle(for: CSVFileReader.self), filename: "Number"))
  }
  
  func testNIAToDecodable() {
    do {
      let nia: [NIADicDecodeSample] = try reader.load(bundle: Bundle(for: CSVFileReader.self), filename: "NIADic")
      print(nia)
      XCTAssertEqual(nia[0].title, "가")
      XCTAssertEqual(nia[1].type, "xp")
      XCTAssertEqual(nia[3].title, "가뇨")
    } catch {
      XCTFail("fail: \(error)")
    }
  }
  
  func testNumberToStringArrayHasHeader() {
    do {
      let number: [[String]] = try reader.load(bundle: Bundle(for: CSVFileReader.self), filename: "Number")
      
      XCTAssertEqual(number.first, ["one", "two", "three"])
    } catch {
      XCTFail("fail: \(error)")
    }
  }
  
  func testNumberToStringArrayHasNotHeader() {
    
    XCTAssertNoThrow(try reader.data(bundle: Bundle(for: CSVFileReader.self), filename: "Number"))
    
    do {
      let number: [[String]] = try reader.load(bundle: Bundle(for: CSVFileReader.self), filename: "Number", hasHeaderRow: false)
      
      XCTAssertEqual(number.first, ["1", "2", "3"])
    } catch {
      XCTFail("fail: \(error)")
    }
  }
}
