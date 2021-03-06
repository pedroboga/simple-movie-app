//
//  MovieTitleCell.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import UIKit

class MovieTitleCell: UITableViewCell {
    static let reuseId = "MovieTitleCell"
    var like = false
    var imageSF = UIImage(systemName: "suit.heart")
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    let likeSymbol: UIButton = {
        let likeButton = UIButton()
        likeButton.tintColor = .white
        likeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        
        return likeButton
    }()
    
    let baseStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let likeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieLabel)
        addSubview(likeSymbol)
        addSubview(baseStackView)
        baseStackView.addArrangedSubview(likeLabel)
        backgroundColor = .black
        
        configView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    private func configView() {
        likeSymbol.setImage(imageSF, for: .normal)
    }
    
    private func configConstraints() {
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        likeSymbol.translatesAutoresizingMaskIntoConstraints = false
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            movieLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieLabel.bottomAnchor.constraint(equalTo:  bottomAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            likeSymbol.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            likeSymbol.leadingAnchor.constraint(equalTo: movieLabel.trailingAnchor, constant: 5),
            likeSymbol.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            likeSymbol.heightAnchor.constraint(equalToConstant: 30),
            likeSymbol.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 5),
            baseStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            baseStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            baseStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            baseStackView.heightAnchor.constraint(equalToConstant: 20)
        ])

    }
    
    @objc func likeAction() {
        print("clicou")
        if like {
            imageSF = UIImage(systemName: "suit.heart.fill")
            likeSymbol.setImage(imageSF, for: .normal)
            like = false
        } else {
            imageSF = UIImage(systemName: "suit.heart")
            likeSymbol.setImage(imageSF, for: .normal)
            like = true
            print("clicou")
        }
        
    }
    
}
