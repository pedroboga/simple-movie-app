//
//  ViewController.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = ViewModel()
    
    var movie: Movie?
    var similarMovies: SimilarMovies?
    var posterPath = "https://image.tmdb.org/t/p/w500"
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MovieTitleCell.self, forCellReuseIdentifier: MovieTitleCell.reuseId)
        table.register(SimilarMovieCell.self, forCellReuseIdentifier: SimilarMovieCell.reuseId)
        return table
    }()
    
    let header = StretchyView(frame: .zero)
    
    private var imageHeader: UIImage = {
        let image = UIImage()
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        configView()
        getMovieData()
        getSimilarMovies()
        
    }
    
    private func configView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        header.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height:  view.frame.size.width)
        tableView.tableHeaderView = header
    }
    
    private func getMovieData() {
        DispatchQueue.main.async {
            self.viewModel.getMovieInfo { movie in
                self.movie = movie
                self.tableView.reloadData()
                let path = "\(self.posterPath)\(movie.posterPath!)"
                self.viewModel.getImage(with: path) { image in
                    self.imageHeader = image
                    self.header.imageView.image = self.imageHeader
                }
            }
        }
    }
    
    private func getSimilarMovies() {
        DispatchQueue.main.async {
            self.viewModel.getSimilarMovies { similar in
                self.similarMovies = similar
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return similarMovies?.results?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cellInfo = tableView.dequeueReusableCell(withIdentifier: MovieTitleCell.reuseId, for: indexPath) as? MovieTitleCell else { return UITableViewCell()}
            cellInfo.selectionStyle = .none
            cellInfo.movieLabel.text = movie?.title
            return cellInfo
        }
        guard let cellSimilar = tableView.dequeueReusableCell(withIdentifier: SimilarMovieCell.reuseId, for: indexPath) as? SimilarMovieCell else { return UITableViewCell() }
        DispatchQueue.main.async {
            let path = "\(self.posterPath)\(self.similarMovies?.results![indexPath.row].posterPath ?? "")"
            self.viewModel.getImage(with: path) { image in
                cellSimilar.posterImage.image = image
            }
            guard let text = self.similarMovies?.results![indexPath.row].releaseDate else { return }
            cellSimilar.yearLabel.text = String(text[0..<4])
            cellSimilar.movieLabel.text = self.similarMovies?.results![indexPath.row].title
            cellSimilar.selectionStyle = .none
        }
        
        return cellSimilar
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyView else { return }
        header.scrollViewDidScroll(scrollView: scrollView)
    }
    
}

extension String {
    subscript (index: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: index)
        return self[charIndex]
    }

    subscript (range: Range<Int>) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let stopIndex = self.index(self.startIndex, offsetBy: range.startIndex + range.count)
        return self[startIndex..<stopIndex]
    }

}
