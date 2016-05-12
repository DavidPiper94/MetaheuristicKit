import UIKit
import XCTest
import MetaheuristicKit

class Tests: XCTestCase {
    
    var GABool = GeneticAlgorithm(type: .Bool, fitnessFunction: (GeneticAlgorithm.simpleBoolFitnessFunction))
        
    var GAFloat = GeneticAlgorithm(type: .Float, fitnessFunction: (GeneticAlgorithm.simpleFloatFitnessFunction))
    
    func testGenerateRandomBitArray() {
        GABool.sizeOfIndividual = 3
        let randomBitArray = GABool.generateRandomBitArray()
        
        XCTAssertTrue(randomBitArray.count == GABool.sizeOfIndividual)
    }
    
    func testGenerateRandomFloatArray() {
        GAFloat.sizeOfIndividual = 3
        let randomFloatArray = GAFloat.generateRandomFloatArray()
        
        XCTAssertTrue(randomFloatArray.count == GAFloat.sizeOfIndividual)
        XCTAssertTrue(randomFloatArray[0] >= GAFloat.minFloatValue && randomFloatArray[0] <= GAFloat.maxFloatValue)
        XCTAssertTrue(randomFloatArray[1] >= GAFloat.minFloatValue && randomFloatArray[1] <= GAFloat.maxFloatValue)
        XCTAssertTrue(randomFloatArray[2] >= GAFloat.minFloatValue && randomFloatArray[2] <= GAFloat.maxFloatValue)
    }
    
    func testSimpleBoolFitnessFunction() {
        let boolArrayA = [true, true, true]
        let boolArrayB = [false, false, false]
        
        XCTAssertTrue(GABool.assessFitness(individual: boolArrayA) == 3)
        XCTAssertTrue(GABool.assessFitness(individual: boolArrayB) == 0)
    }
    
    func testSimpleFloatFitnessFunction() {
        let floatArray = [0.1, 0.2, 0.3]
        
        //XCTAssertTrue(GAFloat.assessFitness(individual: floatArray) == 0.6)
    }
    
    func testBitFlipMutation() {
        let individual = [true, true, false, true]
        
        GABool.probabilityOfMutation = 0.0
        var newIndividual = GABool.bitFlipMutation(individual: individual)
        
        XCTAssertTrue(individual[0] == newIndividual[0])
        XCTAssertTrue(individual[1] == newIndividual[1])
        XCTAssertTrue(individual[2] == newIndividual[2])
        XCTAssertTrue(individual[3] == newIndividual[3])
        
        GABool.probabilityOfMutation = 1.0
        newIndividual = GABool.bitFlipMutation(individual: individual)
        
        XCTAssertTrue(individual[0] != newIndividual[0])
        XCTAssertTrue(individual[1] != newIndividual[1])
        XCTAssertTrue(individual[2] != newIndividual[2])
        XCTAssertTrue(individual[3] != newIndividual[3])
    }
    
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
    
    func testRandomVectorShuffle() {
        var vector = [1,2,3,4,5]
        
        //GABool.randomVectorShuffle(&vector)
        
        XCTAssertTrue(vector.count == 5)
    }
}
