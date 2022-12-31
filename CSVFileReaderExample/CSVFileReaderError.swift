//
//  CSVFileReaderError.swift
//  CSVFileReader
//
//  Created by SwiftMan on 2023/01/01.
//

import Foundation

public enum CSVFileReaderError: Error {
  case invalidFileURL
  case invalidDataEncoding
  case invalidAccessingSecurity
  case keyNotFound
}
