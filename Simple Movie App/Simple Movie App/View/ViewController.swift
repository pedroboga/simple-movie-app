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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()

    let temp = ["aaabb", "bdsbsdb", "btherterge", "kuiluilui", "725782578", "dvdvsds", "yuy45y45y45"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        configView()
        getMovieData()
    }
    
    private func configView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    private func getMovieData() {
        DispatchQueue.main.async {
            self.viewModel.getMovieInfo { movie in
                self.movie = movie
                print(movie.title)
                print(movie.posterPath)
            }
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return temp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = temp[indexPath.row]
        return cell
    }
    
    
}
