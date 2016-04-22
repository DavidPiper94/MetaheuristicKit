# MetaheuristicKit

[![CI Status](http://img.shields.io/travis/DavidPiper94/MetaheuristicKit.svg?style=flat)](https://travis-ci.org/DavidPiper94/MetaheuristicKit)
[![Version](https://img.shields.io/cocoapods/v/MetaheuristicKit.svg?style=flat)](http://cocoapods.org/pods/MetaheuristicKit)
[![License](https://img.shields.io/cocoapods/l/MetaheuristicKit.svg?style=flat)](http://cocoapods.org/pods/MetaheuristicKit)
[![Platform](https://img.shields.io/cocoapods/p/MetaheuristicKit.svg?style=flat)](http://cocoapods.org/pods/MetaheuristicKit)

Dies ist Framework mit einer Sammlung von metaheuristischen Algorithmen, die in Swift implementiert sind.
Sie wurden für mein Proseminar "Metaheuristische Optimierungen" an der Technischen Universität Dortmund im Sommersemester 2016 von mir auf Grundlage des Buchs "Essentials of Metaheuristics" von Sean Luke umgesetzt. 
Dieses Buch ist kostenfrei auf folgender Seite herunterzuladen: 

https://cs.gmu.edu/~sean/book/metaheuristics/

Metaheuristiken sind Optimierungsalgorithmen, welche Probleme versuchen zu lösen, für die keine optimale Lösung bekannt ist. Zu dieser Gruppe von Algorithmen gehören unter anederem die Evolutions-Strategie, der genetische Algorithmus, Hill-Climbing und weitere.
Das Hauptaugenmerk liegt bei diesem Projekt zunächst auf dem genetischen Algorithmus und seinen Bestandteilen Selektion, Crossover und Mutation, später sollen aber noch andere Algorithmen hinzugefügt werden.

Das Framework liegt in Form eines CocoaPod-Projekts vor. CocoaPod ist ein Dependency Manager, welcher das Verwenden von externen Frameworks stark vereinfacht. 

Die wichtigste Datei, welche die Implementierung des genetischen Algorihtmus darstellt, ist [GeneticAlgorithm.swift](https://github.com/DavidPiper94/MetaheuristicKit/blob/master/GeneticAlgorithm.swift). 
Sie befindet sich zum einen außerhalb des eigentlichen Projekts, um schnell gefunden zu werden, und zum anderen als eigentliche Framewok-Klasse in [MetaheuristicKit/MetaheuristicKit/Classes/GeneticAlgorithm.swift](https://github.com/DavidPiper94/MetaheuristicKit/blob/master/MetaheuristicKit/Classes/GeneticAlgorithm.swift).

Zu einem CocoaPod-Projekt gehört auch immer eine beispielhafte Verwendung des Frameworks, diese findet sich unter [MetaheuristicKit/Example/MetaheuristicKit/ViewController.swift](https://github.com/DavidPiper94/MetaheuristicKit/blob/master/Example/MetaheuristicKit/ViewController.swift). Hier werden zwei GeneticAlgorithm-Objekte vom Typ Bool und Float erstellt, die Attribute geändert und anschließend ausgeführt.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

MetaheuristicKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MetaheuristicKit"
```

## Author

DavidPiper94, david.piper@udo.edu

## License

MetaheuristicKit is available under the MIT license. See the LICENSE file for more info.
