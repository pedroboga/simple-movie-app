//
//  ViewModel.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation
import UIKit

class ViewModel {
    let service = Service()
    var movie: Movie?
    var image: UIImage?
    var similarMovies: SimilarMovies?
    
    func getMovieInfo(_ completion: @escaping (Movie) -> Void){
        service.getMovieInfo { [weak self] movie in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movie = movie
                completion(movie)
            }
        }
    }
    
    func getImage(with url: String, _ completion: @escaping (UIImage) -> Void){
        service.setImage(with: url) { [weak self] poster in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = poster
                completion(self.image ?? UIImage())
            }
        }
    }
    
    func getSimilarMovies(_ completion: @escaping (SimilarMovies) -> Void){
        service.getSimilarMovies { [weak self] similar in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.similarMovies = similar
                completion(similar)
            }
        }
    }

}
