//
//  DependencyInjectable.swift
//  EnglishWords
//
//  Created by USER on 2020/05/16.
//  Copyright © 2020 Sangmin. All rights reserved.
//

import Foundation

protocol DependencyInjectable {

    associatedtype Dependency

    /**
     Create instance using dependency.

     - Parameters:
       - dependency: [required] dependent items for instantiation
     */
    static func make(withDependency dependency: Dependency) -> Self
}
