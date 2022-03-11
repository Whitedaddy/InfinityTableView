//
//  ImageRequest.swift
//  ImageScroller
//
//  Created by MacBook on 11.03.2022.
//

import UIKit

class ImageDownloading {
    func GetNewSong()
    {
        guard let requestUrl = URL(string: apiURL) else { return }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        

         
         URLSession.shared.dataTask(with: request)
         {
             (data, response, error) in

             guard error == nil else
             {
                 print ("Error!!!")
                 return
             }
             
             guard let data = data else {return}
//             if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
//                print(JSONString) }
                do
             {
                 let backData = try JSONDecoder().decode(SearchedImages.self, from: data)
                 print(backData.total)
             }
             catch
             {
                 print("Error with decoding")
                 
             }
         } .resume()
     }
}