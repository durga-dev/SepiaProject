//
//  ImageLoader.swift
//  sepia
//
//  Created by User on 15/12/22.
//

import Foundation
import UIKit

protocol ImageLoaderProtocol {
    func loadImage(from url: String)
}

let imageCache = NSCache<NSString, UIImage>()
extension UIImageView: ImageLoaderProtocol {
    
    func loadImage(
        from url: String
    ) {
        guard let finalURL = URL(string: url) else {
            return
        }
        
        if let cachedImage = fetchImageFromCache(url: url) {
            image = cachedImage
        } else {
            subviews.forEach({ $0.removeFromSuperview() })
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.center = center
            fetchImageFromURL(url: finalURL) { imageData in
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                    guard let imageData = imageData,
                    let image = UIImage(data: imageData) else {
                        return
                    }
                    self.image = image
                    imageCache.setObject(image, forKey: url as NSString)
                }
            }
        }
    }
    
    // MARK: - Fetch image from cache
    private func fetchImageFromCache(url: String) -> UIImage? {
        imageCache.object(forKey: url as NSString)
    }
    
    // MARK: - Fetch image from URL
    private func fetchImageFromURL(url: URL, completion: @escaping ((_ imageData: Data?) -> ()) ) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let data = data else {
                return completion(nil)
            }
            
            completion(data)
        }).resume()
    }
}
