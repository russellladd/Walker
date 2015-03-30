//
//  OnWalkViewController.swift
//  Walker
//
//  Created by Russell Ladd on 3/28/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import UIKit
import CoreData
import CoreMotion

protocol OnWalkViewControllerDelegate: class {
    
    func onWalkViewControllerDidCancel()
    func onWalkViewController(onWalkViewController: OnWalkViewController, didFinishWithWalk walk: Walk)
}

class OnWalkViewController: UIViewController {
    
    // MARK: Initialization
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        stepCounter.startStepCountingUpdatesToQueue(NSOperationQueue.mainQueue(), updateOn: 1) { numberOfSteps, date, error in
            self.numberOfSteps = numberOfSteps
        }
    }
    
    // MARK: Model
    
    var context: NSManagedObjectContext!
    
    var date = NSDate()
    
    var numberOfSteps: Int = 0 {
        didSet {
            updateNumberOfStepsLabel()
        }
    }
    
    // MARK: Motion
    
    let stepCounter = CMStepCounter()
    
    // MARK: Delegate
    
    weak var delegate: OnWalkViewControllerDelegate?
    
    // MARK: View
    
    @IBOutlet private weak var numberOfStepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateNumberOfStepsLabel()
    }
    
    private func updateNumberOfStepsLabel() {
        numberOfStepsLabel?.text = numberOfSteps.description
    }
    
    // MARK: Buttons
    
    @IBAction private func quitBarButtonItemAction() {
        
        if numberOfSteps > 0 {
            
            let alertTitle = NSLocalizedString("Are you sure?", comment: "Alert title for quit confirmation")
            
            let alertMessage = "Steps for this walk will be lost."
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
                // Do nothing
            })
            
            alertController.addAction(UIAlertAction(title: "Quit", style: .Destructive) { action in
                self.delegate!.onWalkViewControllerDidCancel()
            })
            
            presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            
            self.delegate!.onWalkViewControllerDidCancel()
        }
    }
    
    @IBAction private func finishButtonDidTouchUpInside() {
        
        let walk = NSEntityDescription.insertNewObjectForEntityForName("Walk", inManagedObjectContext: context) as Walk
        
        walk.date = date
        walk.numberOfSteps = numberOfSteps
        
        context.save(nil)
        
        self.delegate!.onWalkViewController(self, didFinishWithWalk: walk)
    }
    
    @IBAction private func tapGestureRecognizerAction() {
        
        // Disabled because conflicts with step counter API
        
        //numberOfSteps++
    }
}
