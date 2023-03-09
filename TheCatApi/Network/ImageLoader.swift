//
//  ImageLoader.swift
//  TheCatApi
//
//  Created by Oscar David Myerston Vega on 8/03/23.
//

import Foundation
import UIKit


class ImageLoader: ObservableObject {

    @Published private(set) var image: UIImage = UIImage()
    var imageCache = ImageCache.getImageCache()
    var urlString: String?
    var endPoint: String = ""

    init(urlString: String? = "", endPoint : String){
        self.urlString = urlString
        self.endPoint = endPoint
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() {
            return
        }
        guard let urlString = urlString else {
            return
        }
        let url = URL(string: "\(Constants.EndPoints.breedsImage+urlString).jpg")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageResponse(data:response:error:))
        task.resume()
    }

    func getImageResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else {
            print(error!)
            return
        }
        guard let data = data else {
            print("Not found data")
            return
        }
        DispatchQueue.main.async {
            guard let loadImage = UIImage(data: data) else{
                return
            }

            self.imageCache.set(forKey: "\(self.urlString!).jpg", image: loadImage)
            self.image = loadImage
        }
    }

    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        guard let cacheImage = imageCache.get(forKey: "\(urlString).jpg") else {
            return false
        }
        image = cacheImage
        return true
    }
}

class ImageCache {

    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage){
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
