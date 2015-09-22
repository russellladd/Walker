# Walker Construction Outline

1. Go through slides on general MVC
2. Set up view controllers in storyboard with segue
	1. Add quit button with one delegate method
	2. Setup On Walk view hierarchy in storyboard
		- Use blue rectangle for circle
	3. Add no walks label
3. Go through slides on view controllers, views, and basic model
4. Add model to On Walk view controller
	1. Add property for steps
	2. Add outlet for label and method for updating it
	3. Add gesture recognizer
5. Get finish button to work
	1. Create Walk struct
	2. Add delegate method for passing back Walk
	3. Implement finish action
	4. Add method in My Walks view controller
6. Add model to My Walks view controller
	1. Add property
	2. Add collection view
		1. Fill out view hierarchy
		2. Wire up in storyboard
		3. Implement methods
			- Create cell subclass when needed
		4. Call reload in view did load
	3. Implement method to add a new walk
		- Add property observer to walks
7. Bring in circle view and add in storyboard
8. Optional things time permitting
	1. Quit alert
	2. Make circles show more information
9. Core Data
	1. Go back to slides and explain
	2. Create schema
	3. Modify walk file to be NSManagedObject subclass
	4. Paste Core Data snippet in app delegate
	5. Add context to both view controllers and pass through
	6. Update Walk creation in On Walk view controller
	7. Convert My Walks view controller to use NSFetchedResultsController
10. Core Motion
	1. Add CMStepCounter
	2. Add handler in initializer
	3. Disable gesture recognizer