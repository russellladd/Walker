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
        
        stepCounter.startStepCountingUpdatesToQueue(NSOperationQueue.mainQueue(), updateOn: 1) { numberOfSteps, date, error in
            self.numberOfSteps = numberOfSteps
        }
    }
    
    private func updateNumberOfStepsLabel() {
        numberOfStepsLabel?.text = numberOfSteps.description
    }
    
    // MARK: Buttons
    
    @IBAction private func quitBarButtonItemAction() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Continue Walk", comment: "Action sheet title"), style: .Default) { action in
            // Do nothing
        })
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Quit", comment: "Action sheet title"), style: .Destructive) { action in
            self.delegate!.onWalkViewControllerDidCancel()
        })
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction private func finishButtonDidTouchUpInside() {
        
        let walk = NSEntityDescription.insertNewObjectForEntityForName("Walk", inManagedObjectContext: context) as Walk
        
        walk.date = date
        walk.numberOfSteps = numberOfSteps
        
        context.save(nil)
        
        self.delegate!.onWalkViewController(self, didFinishWithWalk: walk)
    }
    
    @IBAction private func tapGestureRecognizerAction() {
        
        numberOfSteps++
    }
}
