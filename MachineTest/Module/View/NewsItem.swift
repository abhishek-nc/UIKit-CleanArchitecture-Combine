//
//  NewsItem.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import Foundation

struct NewsItem: Codable {
  
  var newsTitle: String?
  var newsBannerUrl: String?
  
  enum CodingKeys : String, CodingKey {
    case title = "title"
    case imageUrl = "urlToImage"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    newsTitle = try container.decodeIfPresent(String.self, forKey: .title)
    newsBannerUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
  }
  
  func encode(to encoder: Encoder) throws {
    
  }
  
}

struct Articles: Codable {
  var news: [NewsItem]?
  
  enum CodingKeys : String, CodingKey {
    case articles = "articles"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    news = try container.decodeIfPresent([NewsItem].self, forKey: .articles)
  }
  
  func encode(to encoder: Encoder) throws {
    
  }
}



