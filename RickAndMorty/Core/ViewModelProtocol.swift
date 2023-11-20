//
//  ViewModelProtocol.swift
//  RudoApp
//
//  Created by Fernando Salom Carratala on 15/11/22.
//  Copyright © 2022 Rudo. All rights reserved.
//

protocol ViewModelProtocol {
    func viewReady()
    func viewDidAppear()
    func viewDidDisappear()
    func viewWillAppear()
}

extension ViewModelProtocol {
    func viewReady() { }
    func viewDidAppear() { }
    func viewDidDisappear() { }
    func viewWillAppear() { }
}
