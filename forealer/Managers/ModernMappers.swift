//
//  ModernMappers.swift
//  forealer
//
//  Created by Misha Causur on 10.04.2022.
//

import RealmSwift

typealias DataBaseModelMapper<DataBaseEntity: Object, Entity> = (Entity) -> (DataBaseEntity)
typealias UserModelMapper<DataBaseEntity: Object, Entity> = (DataBaseEntity) -> (Entity)

struct ModernMapper {
    let realm: Realm = {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            print("An error occured: \(error.localizedDescription)")
            fatalError()
        }
    }()
    
    func createUser<DataBase: Object, Model>(user: User, mapper: DataBaseModelMapper<DataBase, Model>) {
        do {
            try realm.write {
                let dataBaseUser = mapper(user as! Model)
                realm.add(dataBaseUser, update: .all)
            }
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func getUser<DataBase: Object, Model>(at id: String, mapper: UserModelMapper<DataBase, Model>) -> User? {
        guard let dataBaseUser = realm.objects(DataBaseUser.self).first(where: { user in
            user.id == id
        }) else { return nil }
        return (mapper(dataBaseUser as! DataBase) as! User)
    }
}
