//
//  CollectionModels.swift
//  forealer
//
//  Created by Misha Causur on 04.05.2022.
//

import Foundation
import UIKit

enum Section: Hashable {
    case collection(header: String)
    
    var title: String {
        switch self {
        case .collection(let header):
            return header
        }
    }
}

enum Item: Hashable {
    case largePhoto(Photo)
    case smallPhoto(Photo)
}

struct Photo {
    let id = UUID()
    let image: UIImage
}

extension Photo: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Mode: Int {
    case monthSummary
    case allPhotos
}
