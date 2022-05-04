//
//  PhotoSummaryCell.swift
//  forealer
//
//  Created by Misha Causur on 04.05.2022.
//

import UIKit

class PhotoSummaryCell: UICollectionViewCell {
    
    private let dayLabel = UILabel()
    
    private let moreButton = UIControl()
    
    private let topGradientView = UIView()
    
    func configure(forMode mode: PhotosViewController.Mode) {
        UIView.animate(withDuration: 0.2) {
            switch mode {
            case .allPhotos:
                self.configureForAllPhotos()
            case .monthSummary:
                self.configureForSummary()
            }
        }
    }

    private func configureForAllPhotos() {
        dayLabel.alpha = 0
        moreButton.alpha = 0
        topGradientView.alpha = 0
        contentView.layer.cornerRadius = 0
    }

    private func configureForSummary() {
        dayLabel.alpha = 1
        moreButton.alpha = 1
        topGradientView.alpha = 1
        contentView.layer.cornerRadius = 16
    }
}
