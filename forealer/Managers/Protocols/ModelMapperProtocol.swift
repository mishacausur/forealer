//
//  ModelMapperProtocol.swift
//  forealer
//
//  Created by Misha Causur on 09.04.2022.
//

import RealmSwift

protocol ModelMapper {
    associatedtype Model
    associatedtype PersistenceModel: Object
    
    func map(_ model: Model) -> PersistenceModel
}
