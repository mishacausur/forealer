//
//  ADataBaseManager.swift
//  forealer
//
//  Created by Misha Causur on 11.04.2022.
//

import RealmSwift
import Foundation
import Combine

public typealias AnySchedulerOf<Scheduler> = AnyScheduler<Scheduler.SchedulerTimeType, Scheduler.SchedulerOptions> where Scheduler: Combine.Scheduler

final class ADataBaseManager: ADataBaseManagerProtocol {
   
    private let configuration: Realm.Configuration
    private let regularScheduler: AnySchedulerOf<DispatchQueue>
    private let listenScheduler: AnySchedulerOf<RunLoop>
    
    init(configuration: Realm.Configuration,
         regularScheduler: AnySchedulerOf<DispatchQueue>,
         listenScheduler: AnySchedulerOf<RunLoop>) {
        self.regularScheduler = regularScheduler
        self.listenScheduler = listenScheduler
        self.configuration = configuration
    }
    
    func realm<S: Scheduler>(scheduler: S) -> AnyPublisher<Realm, Error> {
        return Just((configuration, nil))
            .receive(on: scheduler)
            .tryMap(Realm.init)
            .eraseToAnyPublisher()
    }
    
    func getData<DataBase: Object, Entity>(mapper: @escaping DataBaseToModelMapper<DataBase, Entity>, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Entity?, Error> {
        return realm(scheduler: regularScheduler)
            .map { $0.objects(DataBase.self) }
            .map { block($0).last.map(mapper) }
            .eraseToAnyPublisher()
    }
    
    func listen<DataBase: Object, Entity>(mapper: @escaping DataBaseToModelMapper<DataBase, Entity>, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Entity, Error> {
        
    }
    
    func save<DataBase: Object, Entity>(object: Entity, mapper: @escaping DataBaseModelMapper<DataBase, Entity>, update: Realm.UpdatePolicy) -> AnyPublisher<Void, Error> {
        
    }
    
    func delete<DataBase: Object>(_ type: DataBase.Type, block: @escaping RealmBlock<DataBase>) -> AnyPublisher<Void, Error> {
        
    }
    
}
