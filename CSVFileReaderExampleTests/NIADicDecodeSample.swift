//
//  NIADicDecodeSample.swift
//  CSVFileReaderTests
//
//  Created by SwiftMan on 2023/01/01.
//

import Foundation

struct NIADicDecodeSample: Decodable {
  let title: String
  let type: String?
  let category: String?
  
  enum CodingKeys: String, CodingKey {
    case title = "term"
    case type = "tag"
    case category = "category"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.title = try container.decode(String.self, forKey: .title)
    self.type = try container.decodeIfPresent(String.self, forKey: .type)
    self.category = try container.decodeIfPresent(String.self, forKey: .category)
  }
}
