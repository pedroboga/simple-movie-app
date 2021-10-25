//
//  StretchyView.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import UIKit

class StretchyView: UIView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var imageHeight = NSLayoutConstraint()
    private var imageBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageBottom.isActive = true
        imageHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}
