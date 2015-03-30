func fractionToGoal() -> Double {
    
    let goal = 10
    
    return min((Double(numberOfSteps) / Double(goal)), 1.0)
}
