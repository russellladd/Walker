//
//  AppDelegate.swift
//  Walker
//
//  Created by Russell Ladd on 3/28/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: Window
    
    var window: UIWindow?
    
    // MARK: Application life cycle
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let model = NSManagedObjectModel.mergedModelFromBundles(nil)!
        
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        let storeURL = documentsURL.URLByAppendingPathComponent("Walks.data")
        
        let storeOptions = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]
        
        do {
            try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: storeOptions)
        } catch {
            print(error)
            assertionFailure()
        }
        
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        context.persistentStoreCoordinator = persistentStoreCoordinator
        
        let navigationController = window!.rootViewController as! UINavigationController
        let myWalksViewController = navigationController.viewControllers.first as! MyWalksViewController
        myWalksViewController.context = context
        
        return true
    }
}
