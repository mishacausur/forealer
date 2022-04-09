//
//  PersistenceMapperProtocol.swift
//  forealer
//
//  Created by Misha Causur on 09.04.2022.
//

import RealmSwift

protocol PersistenceMapper {
    associatedtype Model
    associatedtype PersistenceModel: Object
    
    func map(_ persistence: PersistenceModel) -> Model
}
