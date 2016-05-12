//
//  GeneticAlgorithm.swift
//  genetischer Algorithmus
//
//  Created by David Piper on 15.04.16.
//  Copyright © 2016 David Piper. All rights reserved.
//

import Foundation

/**
 Der genetische Algorithmus ist ein Verfahren der metaheuristischen Optimierung und gehört zu den evolutionären Algorithmen. Durch Erstellung einer zufälligen ersten Population und anschließender Bewertung, Auswahl, Vermischung und Veränderung der Individuuen der Population wird eine (häufig annähernd) optimale Lösung zu einem gegebenen Problem gefunden.
 
 - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Kapitel 3.2
 */
public class GeneticAlgorithm {
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Variablen
    public var type:       PossibleTypes
    public var selection:  SelectionAlgorithmen    = .fitnessProportionateSelection
    public var crossover:  CrossoverAlgrorithmen   = .uniformCrossover
    public var mutate:     MutateAlgorithmen
    public var fitnessFunction:  [AnyObject] -> Int
    
    public var sizeOfIndividual:       Int = 5
    public var minFloatValue:          Float = 0.0
    public var maxFloatValue:          Float = 50.0
    public var probabilityOfMutation:  Float = 0.5
    public var probabilityOfCrossover: Float = 0.5
    public var rangeOfMutation:        Float = 3.0
    public var tournamentSize:         Int = 2
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Enums
    ///Definiert die Datentypen, für die der genetische Algorithmus verwendet werden kann.
    public enum PossibleTypes {
        ///Bei Auswahl von .Bool wird der genetische Algorithmus auf Arrays mit Bool-Werten angewendet.
        case Bool
        ///Bei Auswahl von .Float wird der genetische Algorithmus auf Arrays mit Float-Werten angewendet.
        case Float
    }
    
    ///Definiert die Selektionsalgorithmen, die innerhalb des genetischen Algorithmus verwendet werden können.
    public enum SelectionAlgorithmen {
        ///Durch Auswahl von .fitnessProportionateSelection wird die Funktion fitnessProportionateSelection im genetischen Algorithmus zur Selektion verwendet.
        case fitnessProportionateSelection
        ///Durch Auswahl von .stochasticUniversalSampling wird die Funktion stochasticUniversalSampling im genetischen Algorithmus zur Selektion verwendet.
        case stochasticUniversalSampling
        ///Durch Auswahl von .tournamentSelection wird die Funktion tournamentSelection im genetischen Algorithmus zur Selektion verwendet.
        case tournamentSelection
    }
    
    ///Definiert die Crossoveralgorithmen, die innerhalb des genetischen Algorithmus verwendet werden können.
    public enum CrossoverAlgrorithmen {
        ///Durch Auswahl von .onePointCrossover wird die Funktion onePointCrossover im genetischen Algorithmus zur Rekombination verwendet.
        case onePointCrossover
        ///Durch Auswahl von .onePointCrossover wird die Funktion twoPointCrossover im genetischen Algorithmus zur Rekombination verwendet.
        case twoPointCrossover
        ///Durch Auswahl von .onePointCrossover wird die Funktion uniformCrossover im genetischen Algorithmus zur Rekombination verwendet.
        case uniformCrossover
        ///Durch Auswahl von .onePointCrossover wird die Funktion uniformCrossoverAmongKVektors im genetischen Algorithmus zur Rekombination verwendet.
        case uniformCrossoverAmongKVektors
        ///Durch Auswahl von .onePointCrossover wird die Funktion lineRecombination im genetischen Algorithmus zur Rekombination verwendet.
        case lineRecombination
        ///Durch Auswahl von .onePointCrossover wird die Funktion intermediateRecombination im genetischen Algorithmus zur Rekombination verwendet.
        case intermediateRecombination
    }
    
    ///Definiert die Mutationsalgorithmen, die innerhalb des genetischen Algorithmus verwendet werden können.
    public enum MutateAlgorithmen {
        ///Durch Auswahl von .bitFlipMuatation wird die Funktion bitFlipMutation im genetischen Algorithmus zur Mutation verwendet. Dies ist nur bei der Auswahl von .Bool als Typ möglich.
        case bitFlipMutation
        ///Durch Auswahl von .boundedUniformConvolution wird die Funktion boundedUniformConvolution im genetischen Algorithmus zur Mutation verwendet. Dies ist nur bei der Auswahl von .Float als Typ möglich.
        case boundedUniformConvolution
    }
    
    
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Init
    /**
    Erstellt ein neues GeneticAlgorithm-Objekt mit den übergebenen Parametern als Voreinstellung, sowie den Defaultauswahlen für:
     
     - Selektionsalgorithmus (selection = .fitnessProportionateSelection)
     - Crossoveralgorithmus (crossover = .uniformCrossover)
     - Größe des Individuums (sizeOfIndividual = 5)
     - Minimaler Float-Wert eines Float-Individuums (minFloatValue = 0.0)
     - Maximaler Float-Wert eines Float-Individuums (maxFloatValue = 50.0)
     - Wahrscheinlichkeit für die Mutation eines Wertes in einem Individuum (probabilityOMutation = 0.5)
     - Zahlenbereich, in dem die Mutation stattfindet (rangeOfMutation = 3.0)
     
     Diese Werte können über Setter auch nach Initialisierung des Objekts geändert werden.
     
    - Parameter type: Auswahl des Datentypen der Population aus dem enum PossibleTypes (.Bool oder .Float).
    - Parameter fitnessFunction: Eine Funktion, die aus der Eingabe [AnyObject], welches das Individuuum ist, ein Int als Fitness-Wert des Individuums berechnet.
     */
    public init(type: PossibleTypes, fitnessFunction: [AnyObject] -> Int) {
        self.type = type
        self.fitnessFunction = fitnessFunction
        switch type {
            case .Bool:  self.mutate = .bitFlipMutation
            case .Float: self.mutate = .boundedUniformConvolution
        }
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Hauptalgorithmus
    /**
     Sucht aus einer Menge von Individuuen das beste Individuum, indem zufüllige Lösungsmöglichkeiten generiert, bewertet, gemischt und in einem kleinen Rahmen zufüllig verändert werden. Greift dabei auf die Algorithmen assessFitness, selectWithReplacement, crossover und mutate zurück.
     
     - Parameter popsize: Die Größe der aufgebauten Population, also die Anzahl der verschiedenen Individuuen.
     - Parameter times: Die Anzahl der Wiederholungen von Selektion, Crossover und Mutation.
     
     - Returns: Das durch diesen Algorithmus generierte beste Individuum.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 37
     */
    public func geneticAlgorithm(popsize popsize: Int, times: Int) -> [AnyObject] {
                
        guard popsize >= 2 else {
            fatalError("Die Population ist nicht groß genug!")
        }
        
        guard times >= 1 else {
            fatalError("Ein Durchlauf ist zu wenig!")
        }
        
        var population: [[AnyObject]] = []
        
        for _ in 1...popsize {
            switch self.type {
                case .Bool:  population.append(generateRandomBitArray())
                case .Float: population.append(generateRandomFloatArray())
            }
        }
        
        var best = population[0]
        
        for _ in 2...times {
            for individual in population {
                if (assessFitness(individual:best) < assessFitness(individual: individual)) {
                    best = individual
                }
            }
            
            var new: [[AnyObject]] = []
            
            for _ in 1...popsize/2 {
                let parentA = selectWithReplacement(population: population)
                let parentB = selectWithReplacement(population: population)
                
                let children = crossover(parentA: parentA, parentB: parentB)
                
                let childA   = mutate(individual:children.childA)
                let childB   = mutate(individual:children.childB)
                
                new.append(childA)
                new.append(childB)
            }
        }
        
        return best
    }
    
    /**
     Berechnet mit Hilfe der im Initialisierer übergebenen FitnessFunktion die Fitness des Individuums. Wird vom Hauptalgorithmus aufgerufen und ist in dieser Form ausgelagert, um die FitnessFunktion leicht austauschen zu können.
     
     - Parameter individual: Das Individuum, für welches die Fitness bestimmt werden soll.
     
     - Returns: Die berechnete Fitness für das Individuum als Int-Wert.
     */
    public func assessFitness(individual individual: [AnyObject]) -> Int {
        return fitnessFunction(individual)
    }
    
    /**
     Wählt mit Hilfe des in der Variable selection bestimmten Selektionsalgorithmus ein Individuum aus der Population aus. Wird im Hauptalgorithmus aufgerufen und ist in dieser Form ausgelagert, um den Selektionsalgorithmus leicht austauschen zu können.
     
     - Parameter pop: Population als Menge von Arrays, die die Individuuen darstellen
     
     - Returns: Das selektierte Individuum.
     */
    public func selectWithReplacement(population pop: [[AnyObject]]) -> [AnyObject] {
        switch self.selection {
            case .fitnessProportionateSelection:    return fitnessProportionateSelection(population: pop)
            case .stochasticUniversalSampling:      return fitnessProportionateSelection(population: pop) //return stochasticUniversalSampling(pop)
            case .tournamentSelection:              return fitnessProportionateSelection(population: pop)//return tournamentSelection(pop)
        }
    }
    
    /**
     Führt mit Hilfe des in der Variable crossover bestimmten Crossoveralgorithmus eine Vertauschung mancher Werte der Eltern durch und generiert so zwei neue Kinder. Wird im Hauptalgorithmus aufgerufen und ist in dieser Form ausgelagert, um den Crossoveralgorihtmus leicht austauschen zu können.
     
     - Parameter parentA: Elternindividuum
     - Parameter parentB: Elternindividuum
     
     - Returns: Zwei Kinder als Tupel, die durch Vertauschung von Werten der beiden Eltern entstanden sind.
     */
    public func crossover<T>(parentA parentA: [T], parentB: [T]) -> (childA: [T], childB: [T]) {
        switch self.crossover {
            case .onePointCrossover:                return onePointCrossover(parentA: parentA, parentB: parentB)
            case .twoPointCrossover:                return twoPointCrossover(parentA: parentA, parentB: parentB)
            case .uniformCrossover:                 return uniformCrossover(parentA: parentA, parentB: parentB)
            //case .uniformCrossoverAmongKVektors:    return uniformCrossoverAmongKVectors(parents: [parentA, parentB])
            case .lineRecombination:                return onePointCrossover(parentA: parentA, parentB: parentB) //return lineRecombination()
            case .intermediateRecombination:        return onePointCrossover(parentA: parentA, parentB: parentB) //return intermediateRecombination()
        }
    }
    
    /**
     Führt mit Hilfe des in der Variable mutate bestimmten Mutationsalgorithmus eine zufällige Veränderung der Werte des Individuums durch. Wird im Hauptalgorithmus aufgerufen und ist in dieser Form ausgelagert, um den Mutationsalgorihtmus leicht austauschen zu können.
     
     - Parameter individual: Das Individuum, welches mutiert werden soll
     
     - Returns: Das mutierte Individuum.
     */
    public func mutate(individual individual: [AnyObject]) -> [AnyObject] {
        switch self.mutate {
            case .bitFlipMutation:                  return bitFlipMutation(individual: individual as! [Bool])
            case .boundedUniformConvolution:        return boundedUniformConvolution(individual: individual as! [Float])
        }
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Population
    /**
     Generiert ein Boolean-Array mit zufälligen Werten der als Variable sizeOfIndividual gespeicherten Länge.
     
     - Returns: Ein Array von zufälligen Bool-Werten.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 37
     */
    public func generateRandomBitArray() -> [Bool] {
        var array: [Bool] = []
        
        for _ in 1...sizeOfIndividual {
            if (0.5 > randomFloatInRange(firstNum: 0.0, secondNum: 1.0)) {
                array.append(true)
            } else {
                array.append(false)
            }
        }
        
        return array
    }

    /**
     Generiert ein Float-Array mit zufälligen Werten der als Variable sizeOfIndividual gespeicherten Länge. Dabei liegen die Zahlen zwischen den Werten der Variablen minFloatValue und maxFloatValue.
     
     - Returns: Ein Array von zufälligen Float-Werten.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 19
     */
    public func generateRandomFloatArray() -> [Float] {
        var array: [Float] = []
        
        for _ in 1...sizeOfIndividual {
            array.append(randomFloatInRange(firstNum: minFloatValue, secondNum: maxFloatValue))
        }
        
        return array
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - FitnessFunctionsExamples
    /**
     Berechnet aus einem Bool-Array auf einfache Art die Fitness. Die Fitness entspricht dabei der Anzahl der true-Werte.
     Beim Einsatz dieser FitnessFunktion wird also versucht, ein Individuum mit möglichst vielen true-Werten zu generieren.
     
     - Parameter individual: Das Individuum, für das die Fitness bestimmt werden soll.
     
     - Returns: Die Fitness des Individuums als Int.
     */
    public static func simpleBoolFitnessFunction(individual individual: [AnyObject]) -> Int {
        var fitness = 0
        let boolArray = individual as! [Bool]
        for index in 0...individual.count-1 {
            if boolArray[index] {
                fitness += 1
            }
        }
        return fitness
    }
    
    /**
     Berechnet aus einem Float-Array auf einfache Art die Fitness. Die Fitness entspricht dabei der Summe aller Float-Werte.
     Beim Einsatz dieser FitnessFunktion wird also versucht, ein Individuum mit möglichst hohen Float-Werten zu generieren.
     
     - Parameter individual: Das Individuum, für das die Fitness bestimmt werden soll.
     
     - Returns: Die Fitness des Individuums als Int.
     */
    public static func simpleFloatFitnessFunction(individual individual: [AnyObject]) -> Int {
        var fitness = 0
        let floatArray = individual as! [Float]
        for index in 0...individual.count-1 {
            fitness += Int(floatArray[index])
        }
        return fitness
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Selection
    /**
     Durch eine zufällige Zahl wird aus dem durch die Hilfsfunktion builtUpFitnessArray zurückgegebenem Array ein Individuum selektiert.
     
     - Parameter population: Die gesamte Population, aus der ein Individuum selektiert werden soll.
     
     - Returns: Das selektierte Individuum.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 43
     */
    public func fitnessProportionateSelection(population pop: [[AnyObject]]) -> [AnyObject] {
        let length = pop[0].count
        
        var fitnesses: [Int] = builtUpFitnessArray(population: pop)
        
        let n = Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(fitnesses[length-1])))
        
        for index in 2...length {
            if (fitnesses[index-1] < n && n <= fitnesses[index]) {
                return pop[index]
            }
        }
        return pop[0]
    }
    
    /**
     Hilfsfunktion zu Selektionsalgorithmen, um die Fitness jedes Individuums in einem Array zu speichern, auf das bei der Selektion zurückgegriffen werden kann. Dabei steht ein hoher Fitnesswert in dem Array für eine hohe Wahrscheinlichkeit, dass das entsprechende Individuum selektiert wird. Daher wird, falls alle Fitness-Werte 0 sind, alle Werte auf 1 gesetzt.
     
     - Parameter population: Die Population, für die das FitnessArray aufgebaut werden soll.
     
     - Returns: Ein Array aus Int-Werten.
     */
    public func builtUpFitnessArray(population pop: [AnyObject]) -> [Int] {
        var fitnesses: [Int] = []
        let length = pop[0].count
        
        for index in 0...pop.count-1 {
            fitnesses.append(assessFitness(individual: pop[index] as! [AnyObject]))
        }
        
        if (containsOnlyZeros(array: fitnesses)) {
            for index in 0...pop.count-1 {
                fitnesses[index] = 1
            }
        }
        
        for index in 1...length-1 {
            fitnesses[index] = fitnesses[index] + fitnesses[index-1]
        }
        
        return fitnesses
    }
    
    /**
     <#Description#>
     
     - Parameter population: Die gesamte Population, aus der ein Individuum selektiert werden soll.
     
     - Returns: Das selektierte Individuum.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 44
     */
    // TODO: public func stochasticUniversalSampling<T>(population pop: [[T]]) -> [T] {}
    
    /**
     Selection eines Individuums durch vergleich der Fitness mit zufälligem anderen Individuum.
     
     - Parameter population: Die gesamte Population, aus der ein Individuum selektiert werden soll.
     
     - Returns: Das selektierte Individuum.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 45
     */
    public func tournamentSelection(population pop: [[AnyObject]]) -> [AnyObject] {
        var best = pop[Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(pop.count)))]
        var next: [AnyObject]
        
        for _ in 0...tournamentSize {
            next = pop[Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(pop.count)))]
            if assessFitness(individual: next) >= assessFitness(individual: best) {
                best = next
            }
        }
        
        return best
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Crossover
    /**
     Tauscht die Werte von zwei Individuen nach einem zufällig gewählten Index miteinander aus.
     
     - Parameter parentA: Elternindividuum
     - Parameter parentB: Elternindividuum
     
     - Returns: Zwei Kinder als Tupel, die durch Vertauschung von Werten der beiden Eltern entstanden sind.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 38
     */
    public func onePointCrossover<T>(parentA parentA: [T], parentB: [T]) -> (childA: [T], childB: [T]) {
        
        var childA = parentA
        var childB = parentB
        
        let cut = Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(parentA.count)))
        
        if cut != 0 {
            for element in cut-1...parentA.count-1 {
                valueSwap(value1: &childA[element], value2: &childB[element])
            }
        }
        
        return (childA, childB)
    }
    
    /**
     Tauscht die Werte von zwei Individuen zwischen zwei zufällig gewählten Indizes aus.
     
     - Parameter parentA: Elternindividuum
     - Parameter parentB: Elternindividuum
     
     - Returns: Zwei Kinder als Tupel, die durch Vertauschung von Werten der beiden Eltern entstanden sind.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 39
     */
    public func twoPointCrossover<T>(parentA parentA: [T], parentB: [T]) -> (childA: [T], childB: [T]) {
        
        var childA = parentA
        var childB = parentB
        
        var cut1 = Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(parentA.count)))
        var cut2 = Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(parentA.count)))
        
        if (cut1 > cut2) {
            valueSwap(value1: &cut1, value2: &cut2)
        }
        
        if cut1 != cut2 {
            for element in cut1-1...cut2-1 {
                valueSwap(value1: &childA[element], value2: &childB[element])
            }
        }
        
        return (childA, childB)
    }
    
    /**
     Tauscht die Werte von zwei Individuen aus, indem für jeden Index eine zufällige Zahl gewählt wird. Liegt diese Zahl über der in der Variable probabilityOfCrossover gespeicherten Wahrscheinlichkeit, werden die Werte ausgetauscht, ansonsten nicht. Dies kann für jeden Wert unanbhängig von den anderen geschehen.
     
     - Parameter parentA: Elternindividuum
     - Parameter parentB: Elternindividuum
     
     - Returns: Zwei Kinder als Tupel, die durch Vertauschung von Werten der beiden Eltern entstanden sind.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 39
     */
    public func uniformCrossover<T>(parentA parentA: [T], parentB: [T]) -> (childA: [T], childB: [T]) {
        
        var childA = parentA
        var childB = parentB
        
        for element in 0...parentA.count-1 {
            if (probabilityOfCrossover >= randomFloatInRange(firstNum: 0.0, secondNum: 1.0)) {
                valueSwap(value1: &childA[element], value2: &childB[element])
            }
        }
        
        return (childA, childB)
    }
    
    /**
     Tauscht die Werte von mehreren Individuen gleichzeigit aus. Damit nicht zufällig nur unter zwei Individuuen ausgetauscht wird, werde die Elemente gemischt.
     
     - Parameter parents: Die Menge der Individuuen, aus denen die Kinder generiert werden sollen.
     
     - Returns: Die Menge der Rekombinierten Individuen.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 41
     */
    public func uniformCrossoverAmongKVectors<T>(parents parents: [[T]]) -> [[T]] {
        var mix: [T] = []
        var result: [[T]] = []
        var individual: [T]
        
        for index in 0...parents.count-1 {
            if probabilityOfCrossover >= randomFloatInRange(firstNum: 0.0, secondNum: 1.0) {
                
                for otherIndex in 0...parents.count-1 {
                    individual = parents[otherIndex]
                    mix[otherIndex] = individual[index]
                }
                
                randomVectorShuffle(&mix)
                
                for otherIndex in 0...parents.count-1 {
                    individual = parents[otherIndex]
                    individual[index] = mix[otherIndex]
                    result[otherIndex] = individual
                }
            }
        }
        
        return result
    }
    
    /**
     <#Description#>
     
     - Parameter <#Param1#>: <#Description#>
     - Parameter <#Param2#>: <#Description#>
     
     - Returns: <#ReturnValue#>
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 42
     */
    // TODO: public func lineRecombination() {}
    
    /**
     <#Description#>
     
     - Parameter <#Param1#>: <#Description#>
     - Parameter <#Param2#>: <#Description#>
     
     - Returns: <#ReturnValue#>
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 42
     */
    // TODO: public func intermediateRecombination() {}

    //----------------------------------------------------------------------------------------------
    // MARK: - Mutation
    /**
     Mutiert ein Array aus Bool-Werten, indem mit einer in der Variable probabilityOfMutation festgelegten Wahrscheinlichkeit True gegen False und False gegen True ausgetauscht wird. Dies kann für jedes Element unabhängig von den anderen passieren.
     
     - Parameter individual: Das Individuum, welches mutiert werden soll.
     
     - Returns: Das mutierte Individuum.
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 38
     */
    public func bitFlipMutation(individual individual: [Bool]) -> [Bool] {
        var newIndividual = individual
        for i in 0...individual.count-1 {
            if (probabilityOfMutation >= randomFloatInRange(firstNum: 0.0, secondNum: 1.0)) {
                newIndividual[i] = !individual[i]
            }
        }
        return newIndividual
    }
    
    /**
     Mutiert ein Array aus Float-Werten, indem mit einer in der Variable probabilityOfMutation festgelegten Wahrscheinlichkeit die Werte um eine zufällige Zahl innerhalb des in der Variable rangeOfMutation festgelegten Bereichs verändert werden. Dies kann für jedes Element unabhängig von den anderen passieren.
     
     - Parameter individual: Das Individuum, welches mutiert werden soll.
     
     - Returns: Das mutierte Individuum
     
     - SeeAlso: "Essentials of Metaheuristics", Sean Luke, Seite 19
     */
    public func boundedUniformConvolution(individual individual: [Float]) -> [Float] {
        var newIndividual = individual
        var n : Float
        
        for number in 0...individual.count-1 {
            if (probabilityOfMutation >= randomFloatInRange(firstNum: 0.0, secondNum: 1.0)) {
                repeat {
                    n = randomFloatInRange(firstNum: -rangeOfMutation, secondNum: rangeOfMutation)
                } while !(minFloatValue <= individual[number] + n && individual[number] + n <= maxFloatValue)
                newIndividual[number] = individual[number] + n
            }
        }
        
        return newIndividual
    }
    
    //----------------------------------------------------------------------------------------------
    // MARK: - Helper
    /**
     Wählt einen zufälligen Float-Wert zwischen den zwei übergebenen Grenzen aus.
     
     - Parameter firstNum: Die untere Grenze für den Zufallswert.
     - Parameter secondNum: Die obere Grenze für den Zufallswert
     
     - Returns: Der zufällige Float-Wert.
     */
    public func randomFloatInRange(firstNum firstNum: Float, secondNum: Float) -> Float {
        return Float(arc4random()) / Float(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    /**
     Tauscht zwei Werte miteinander aus.
     
     - Parameter value1: Erster zutauschender Wert
     - Parameter value2: Zweiter zutauschender Wert

     - Returns: Die beiden vertauschten Werte.
     */
    public func valueSwap<T>(inout value1 value1: T, inout value2: T) {
        let oldValue1 = value1
        value1 = value2
        value2 = oldValue1
    }
    
    /**
     Überprüft, ob ein Array nur 0en als Elemente enthält. Wird in den Selektionsmethoden verwendet.
     
     - Parameter array: Das zu überprüfende Array.
     
     - Returns: True, wenn das Array nur 0en als Elemente enthält, False sonst.
     */
    public func containsOnlyZeros(array array: [Int]) -> Bool {
        for index in 0...array.count-1 {
            if array[index] != 0 {
                return false
            }
        }
        return true
    }
    
    /**
     Mischt ein Array mit beliebigem Typ zufällig.
     
     - Parameter array: Das zu mischende Array.
     
     - Returns: Das gemischte Array.
     */
    public func randomVectorShuffle<T>(inout array: [T]) {
        let length = array.count
        for index in 1...length-1 {
            let otherIndex = Int(randomFloatInRange(firstNum: 0.0, secondNum: Float(length)))
            valueSwap(value1: &array[index], value2: &array[otherIndex])
        }
    }
}
