//
//  ImageRequest.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit

enum Result {
    case success
    case failture
}

class ImageDownloading {
    
    let apiKey = "26099283-48c3653394e25a69e75ca7763"
    let apiSearchRequest = "minimalism+wallpapers"
    let ghostImage = Hit(id: 1, pageURL: "", tags: "Network troubles", webformatURL: "")
    
    func GetNewSong(page: Int, completed: @escaping (_ data: SearchedImages?) -> () )  {
        let apiURL = "https://pixabay.com/api/?key="+apiKey+"&q="+apiSearchRequest+"&page="+String(page)
        
        guard let requestUrl = URL(string: apiURL) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)  {
            (data, response, error) in
            
            guard error == nil else  {
                print ("Error!!!")
                let err = SearchedImages(total: 0, totalHits: 1, hits: [self.ghostImage])
                completed(err)
                return
            }
            guard let data = data else {return}
            do  {
                let backData = try JSONDecoder().decode(SearchedImages.self, from: data)
                print(backData.total)
                print("Request complete")
                completed(backData)
            }
            catch   {
                print("Error with decoding")
            }
        } .resume()
    }
}
