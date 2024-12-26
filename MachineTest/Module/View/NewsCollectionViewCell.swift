//
//  NewsCollectionViewCell.swift
//  MachineTest
//
//  Created by Abhishek Chandrashekar on 09/11/20.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var newsBanner: UIImageView!
  @IBOutlet weak var newsTittle: UILabel!
  
  func updateNewsCell(news:NewsItem?) {
    self.newsTittle.text = news?.newsTitle ?? ""
    if let imageUrl = news?.newsBannerUrl {
      self.newsBanner.downloaded(from: imageUrl, contentMode: UIView.ContentMode.scaleToFill)
      
    }
  }
  
}


extension UIImageView {
  func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    contentMode = mode
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard
        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
        let data = data, error == nil,
        let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { [weak self] in
        self?.image = image
      }
    }.resume()
  }
  func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
    guard let url = URL(string: link) else { return }
    downloaded(from: url, contentMode: mode)
  }
}

