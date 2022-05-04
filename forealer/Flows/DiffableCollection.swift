//
//  DiffableCollection.swift
//  forealer
//
//  Created by Misha Causur on 04.05.2022.
//

import Foundation
import UIKit

typealias Datasource = UICollectionViewDiffableDataSource<Section, Item>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>


final class PhotosViewController: UIViewController {
    
    enum Mode: Int {
        case monthSummary
        case allPhotos
    }
    
    private var datasource: Datasource!
    
    private let collectionView = UICollectionView()
    
    private var mode = Mode.allPhotos
    
    private let photos1 = Photo.demoPhotos.prefix(4)
    private let photos2 = Photo.demoPhotos.suffix(4)
    
    private func layoutSection(forIndex index: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let photoHeight: NSCollectionLayoutDimension
        switch mode {
        case .monthSummary:
            photoHeight = .fractionalWidth(1.0)
        case .allPhotos:
            photoHeight = .fractionalWidth(0.8)
        }
        
        let photoItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: photoHeight))
        
        if mode == .monthSummary {
            photoItem.contentInsets = .init(top: 2, leading: 16, bottom: 2, trailing: 16)
        } else {
            photoItem.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
        }
        
        let smallPhotoItem = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalWidth(1/3)))
        smallPhotoItem.contentInsets = .init(top: 0, leading: 2, bottom: 0, trailing: 2)
        
        let photoGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3)), subitem: smallPhotoItem, count: 3)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500)), subitems: [photoItem, photoGroup])
        
        let section = NSCollectionLayoutSection(group: group)
        
        if mode == .monthSummary {
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            section.boundarySupplementaryItems = [headerElement]
        }
        return section
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: layoutSection(forIndex:environment:))
    }
    
    @objc func modeSegmentedControlValueChanged(sender: UISegmentedControl) {
        mode = Mode(rawValue: sender.selectedSegmentIndex)!
        datasource.apply(snapshot(), animatingDifferences: true)
        let summaryCells = collectionView.visibleCells.compactMap({ $0 as? PhotoSummaryCell })
        summaryCells.forEach { (cell) in
            cell.configure(forMode: mode)
        }
    }
    
    func snapshot() -> Snapshot {
        var snapshot = Snapshot()

        let julyCollection = Section.collection(header: "July 2020")
        let augustCollection = Section.collection(header: "August 2020")

        snapshot.appendSections([julyCollection, augustCollection])

        snapshot.appendItems([.largePhoto(photos1.first!)], toSection: julyCollection)
        snapshot.appendItems([.largePhoto(photos2.first!)], toSection: augustCollection)

        if mode == .allPhotos {
            snapshot.appendItems(photos1.dropFirst().map { Item.photo($0) }, toSection: julyCollection)
            snapshot.appendItems(photos2.dropFirst().map { Item.photo($0) }, toSection: augustCollection)
        }

        return snapshot
    }
}


