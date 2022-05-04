//
//  ADataBaseManagerProtocol.swift
//  forealer
//
//  Created by Misha Causur on 10.04.2022.
//

import RealmSwift
import Combine

typealias RealmBlock<DataBaseEntity: Object> = () -> (DataBaseEntity)

protocol ADataBaseManagerProtocol: AnyObject {
    
//    func getData<DataBase: Object, Entity>(mapper: @escaping DataBaseToModelMapper<DataBase, Entity>, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Entity?, Error>
    
    func listen<DataBase: Object, Entity>(mapper: @escaping DataBaseToModelMapper<DataBase, Entity>, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Entity, Error>
    
    func save<DataBase: Object, Entity>(object: Entity, mapper: @escaping DataBaseModelMapper<DataBase, Entity>, update: Realm.UpdatePolicy) -> AnyPublisher<Void, Error>
    
    func delete<DataBase: Object>(_ type: DataBase.Type, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Void, Error>
    
}

