//
//  SimilarMovieCell.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import UIKit


class SimilarMovieCell: UITableViewCell {

    static let reuseId = "SimilarMovieCell"
    
    let posterImage: UIImageView = {
        let image = UIImageView()
        //image.contentMode = .scaleAspectFill
        return image
    }()
    
    var movieStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .equalCentering
        //stack.alignment = .lastBaseline
        stack.spacing = 1
        return stack
    }()
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(posterImage)
        addSubview(movieStackView)
        movieStackView.addArrangedSubview(movieLabel)
        movieStackView.addArrangedSubview(yearLabel)
        backgroundColor = .black
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func configConstraints() {
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        movieStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImage.heightAnchor.constraint(equalToConstant: 100),
            posterImage.widthAnchor.constraint(equalToConstant: 65)
        ])
        
        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: topAnchor),
            movieStackView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: 10),
            movieStackView.bottomAnchor.constraint(equalTo:  bottomAnchor, constant: -10),
            movieStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])

    }
    
    override func prepareForReuse() {
        posterImage.image = UIImage()
    }

}
