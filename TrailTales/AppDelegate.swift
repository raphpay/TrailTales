//
//  AppDelegate.swift
//  TrailTales
//
//  Created by Raphaël Payet on 11/09/2023.
//

import SwiftUI
import FirebaseCore
import RealmSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
        
        let config = Realm.Configuration(
            schemaVersion: 2, // Increment the schema version
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    migration.enumerateObjects(ofType: Hike.className()) { oldObject, newObject in
                        newObject?["story"] = ""
                    }
                }
            }
        )
        
        // Apply the configuration
        Realm.Configuration.defaultConfiguration = config
        
        return true
    }
}
