//
//  Mappers.swift
//  forealer
//
//  Created by Misha Causur on 10.04.2022.
//

import RealmSwift

struct Mapper {
    
    let realm: Realm = {
        do {
            let realm = try Realm()
            return realm
        } catch let error {
            print("An error occured: \(error.localizedDescription)")
            fatalError()
        }
    }()
    
    func createUser<T: ModelMapper>(user: UserModel, mapper: T) {
        do {
            try realm.write {
                let dataBaseUser = mapper.map(user as! T.Model)
                realm.add(dataBaseUser, update: .all)
            }
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func getUsers<T: PersistenceMapper>(at id: String, mapper: T) -> UserModel? {
        guard let dataBaseUser = realm.objects(DataBaseUser.self).first { $0.id == id } else { return nil }
        return mapper.map(dataBaseUser)
    }
}
