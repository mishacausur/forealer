//
//  DataBaseModel.swift
//  forealer
//
//  Created by Misha Causur on 09.04.2022.
//

import RealmSwift

class DataBaseUser: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
}
