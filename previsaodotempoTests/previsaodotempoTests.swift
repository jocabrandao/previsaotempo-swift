//
//  previsaodotempoTests.swift
//  previsaodotempoTests
//
//  Created by João Carlos Brandão on 25/03/17.
//  Copyright © 2017 BWmobi. All rights reserved.
//

import XCTest
@testable import previsaodotempo

class previsaodotempoTests: XCTestCase {
    
    let previsaoTempoVC = PrevisaoTempoVC()
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCollectionHasItems() {
        let exp = expectation(description: "Esperando que o load da previsão do tempo da semana falhe.")
        previsaoTempoVC.donwloadDetalhesPrevisaoTempo { 
           exp.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertGreaterThan(previsaoTempoVC.previsoesTempo.count, 0, "Não foi carregada a lista com a previsão do tempo da semana.")
    }
    
}
