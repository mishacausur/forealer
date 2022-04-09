//
//  DataBaseManager.swift
//  forealer
//
//  Created by Misha Causur on 09.04.2022.
//

import Foundation

struct DataBaseManager: ModelMapper {
    
    func map(_ model: UserModel) -> DataBaseUser {
        let user = DataBaseUser()
        user.id = model.id
        user.name = model.name
        return user
    }
}
