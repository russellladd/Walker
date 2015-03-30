//
//  ViewController.swift
//  Walker
//
//  Created by Russell Ladd on 3/28/15.
//  Copyright (c) 2015 GRL5. All rights reserved.
//

import UIKit
import CoreData

class MyWalksViewController: UIViewController, NSFetchedResultsControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, OnWalkViewControllerDelegate {
    
    // MARK: Model
    
    var context: NSManagedObjectContext!
    
    private lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "Walk")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        
        return controller
    }()
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        collectionView.reloadData()
        updateNoWalksLabelHidden()
    }
    
    // MARK: View
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var noWalksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController.performFetch(nil)
        
        collectionView.reloadData()
        updateNoWalksLabelHidden()
    }
    
    func updateNoWalksLabelHidden() {
        noWalksLabel.hidden = fetchedResultsController.fetchedObjects!.count > 0
    }
    
    // MARK: Collection view data source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Walk Cell", forIndexPath: indexPath) as WalkCell
        
        let walk = fetchedResultsController.objectAtIndexPath(indexPath) as Walk
        
        cell.numberOfStepsLabel.text = walk.numberOfSteps.description
        
        cell.circleView.alpha = CGFloat(0.5 + 0.5 * walk.fractionToGoal())
        
        return cell
    }
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
            
        case "Start Walk":
            let navigationController = segue.destinationViewController as UINavigationController
            let onWalkViewController = navigationController.viewControllers.first as OnWalkViewController
            onWalkViewController.context = context
            onWalkViewController.delegate = self
            
        default:
            assertionFailure("Unknown segue identifier")
        }
    }
    
    // MARK: Walk view controller delegate
    
    func onWalkViewControllerDidCancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func onWalkViewController(onWalkViewController: OnWalkViewController, didFinishWithWalk walk: Walk) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}
