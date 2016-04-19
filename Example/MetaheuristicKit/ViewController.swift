//
//  ViewController.swift
//  MetaheuristicKit
//
//  Created by DavidPiper94 on 04/19/2016.
//  Copyright (c) 2016 DavidPiper94. All rights reserved.
//

import UIKit
import MetaheuristicKit

class ViewController: UIViewController {

    var GABool = GeneticAlgorithm(type: .Bool, fitnessFunction: (GeneticAlgorithm.simpleBoolFitnessFunction))
    var GAFloat = GeneticAlgorithm(type: .Float, fitnessFunction: (GeneticAlgorithm.simpleFloatFitnessFunction))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GABool.crossover = .onePointCrossover
        GAFloat.maxFloatValue = 100.0
        
        print("--------------------------------\(GABool.geneticAlgorithm(popsize: 10, times: 10))--------------------------------")
        print("--------------------------------\(GAFloat.geneticAlgorithm(popsize: 10, times: 10))--------------------------------")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

