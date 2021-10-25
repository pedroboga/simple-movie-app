//
//  Service.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation

class Service {
    
    private let apiKey = "d020099a83f960ab4c4379700817a609"
    private let movieId = "513434"
    
    func getMovieInfo(_ completion: @escaping (Movie) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(apiKey)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { return }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decode = try jsonDecoder.decode(Movie.self, from: data)
                    DispatchQueue.main.async {
                        completion(decode)
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
}
