//
//  ModelManager.swift
//  forealer
//
//  Created by Misha Causur on 10.04.2022.
//

import Foundation

struct ModelManager: PersistenceMapper {
    
    func map(_ persistence: DataBaseUser) -> UserModel {
        return UserModel(id: persistence.id, name: persistence.name)
    }
}
