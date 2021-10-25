//
//  ViewModel.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation

class ViewModel {
    let service = Service()
    var movie: Movie?
    
    func getMovieInfo(_ completion: @escaping (Movie) -> Void){
        service.getMovieInfo { [weak self] movie in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.movie = movie
                completion(movie)
            }
        }
    }

}
