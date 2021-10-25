//
//  Service.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation
import UIKit

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
    
    func setImage(with urlString: String, _ completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                return
            }
            //let image = UIImage(data: data)
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image ?? UIImage())
                //self.imageHeader = image ?? UIImage()
            }
        }
        task.resume()
    }
    
    func getSimilarMovies(_ completion: @escaping (SimilarMovies) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(apiKey)") else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { return }
            
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decode = try jsonDecoder.decode(SimilarMovies.self, from: data)
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
