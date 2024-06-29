//
//  ShadowImageView.swift
//  NaverSearchBookSampleApp
//
//  Created by user on 6/30/24.
//

import UIKit

class ShadowImageView: UIImageView {
    
    override var image: UIImage? {
        didSet {
            updateShadowPath()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
    
    func setupShadow(opacity: Float, offset: CGSize, radius: CGFloat) {
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }

    private func updateShadowPath() {
        guard let image = image else { return }
        
        let imageAspect = image.size.width / image.size.height
        let width = bounds.size.height * imageAspect
        
        var imageFrame = bounds
        imageFrame.size.width = width
        imageFrame.origin.x = (bounds.size.width - width) / 2
        
        layer.shadowPath = UIBezierPath(rect: imageFrame).cgPath
    }
}
