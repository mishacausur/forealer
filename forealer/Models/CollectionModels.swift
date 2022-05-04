//
//  CollectionModels.swift
//  forealer
//
//  Created by Misha Causur on 04.05.2022.
//

import Foundation

enum Section: Hashable {
    case collection(header: String)
    
    var title: String {
        switch self {
        case .collection(let header):
            return header
        }
    }
}

enum Item {
    case largePhoto
    case smallPhoto
}
