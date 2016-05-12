import UIKit
import XCTest
import MetaheuristicKit

class Tests: XCTestCase {
    
    var GABool = GeneticAlgorithm(type: .Bool, fitnessFunction: (GeneticAlgorithm.simpleBoolFitnessFunction))
        
    var GAFloat = GeneticAlgorithm(type: .Float, fitnessFunction: (GeneticAlgorithm.simpleFloatFitnessFunction))
    
    
    func testRandomFloatInRange() {
        let random = GABool.randomFloatInRange(firstNum: 0.0, secondNum: 1.0)
        
        XCTAssertTrue(random <= 1.0 && random >= 0.0)
    }
    
    func testValueSwap() {
        var valueA = 1
        var valueB = 2
        
        GABool.valueSwap(value1: &valueA, value2: &valueB)
        
        XCTAssertTrue(valueA == 2)
        XCTAssertTrue(valueB == 1)
    }
    
    func testContainsOnlyZeros() {
        let arrayWithOnlyZeros = [0,0,0,0]
        let arrayWithNotOnlyZeros = [1,0,1,1]
        
        XCTAssertTrue(GABool.containsOnlyZeros(array: arrayWithOnlyZeros))
        XCTAssertFalse(GABool.containsOnlyZeros(array: arrayWithNotOnlyZeros))
    }
}
