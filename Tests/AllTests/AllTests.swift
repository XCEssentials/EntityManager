//
//  Main.swift
//  MKHEntityManagerTst
//
//  Created by Maxim Khatskevich on 8/18/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

import XCTest

import XCEEntityManager

//---

class Main: XCTestCase
{
    struct Person: Entity
    {
        let enm_entityId: EntityId
    }
    
    //---
    
    func testEntityWrapperReusability()
    {
        let p = Person(enm_entityId: "1")
        let anotherP = Person(enm_entityId: "2")
        
        let w1 = EntityManager.wrap(p)
        let w2 = EntityManager.wrap(p)
        let w3 = EntityManager.wrap(anotherP)
        
        XCTAssert(w1 === w2)
        XCTAssert(w1.entity.enm_entityId == w2.entity.enm_entityId)
        
        XCTAssert(w2 !== w3)
        XCTAssert(w2.entity.enm_entityId != w3.entity.enm_entityId)
    }
}
