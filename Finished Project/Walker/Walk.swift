//
//  Walk.swift
//  Walker
//
//  Created by Russell Ladd on 3/28/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import Foundation
import CoreData

class Walk: NSManagedObject {
    
    @NSManaged var date: NSDate
    @NSManaged var numberOfSteps: Int
    
    func fractionToGoal() -> Double {
        
        let goal = 10
        
        return min((Double(numberOfSteps) / Double(goal)), 1.0)
    }
}
