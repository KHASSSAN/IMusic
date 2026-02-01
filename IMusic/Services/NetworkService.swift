//
//  NetworkService.swift
//  IMusic
//
//  Created by Алексей Пархоменко on 12/08/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit
import Alamofire


class NetworkService {
    
    func fetchTracks(searchText: String, competion: @escaping (SearchResponse?) -> Void)  {
        let url = "https://itunes.apple.com/search"
        let parameters: [String: String] = [
            "term": searchText,
            "limit": "10",
            "media": "music"
        ]

        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: SearchResponse.self) { (response: AFDataResponse<SearchResponse>) in
                switch response.result {
                case .success(let objects):
                    competion(objects)
                case .failure(let error):
                    print("Error received requesting data: \(error.localizedDescription)")
                    competion(nil as SearchResponse?)
                }
            }
    }
    
}
