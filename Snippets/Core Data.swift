let model = NSManagedObjectModel.mergedModelFromBundles(nil)!

let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)

let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL
let storeURL = documentsURL.URLByAppendingPathComponent("Walks.data")

let storeOptions = [NSInferMappingModelAutomaticallyOption: true, NSMigratePersistentStoresAutomaticallyOption: true]

var error: NSError?
persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: storeOptions, error: &error)
if let error = error { println(error) }

let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
