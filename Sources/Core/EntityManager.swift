//
//  Main.swift
//  MKHEntityManager
//
//  Created by Maxim Khatskevich on 08/18/16.
//  Copyright © 2016 Maxim Khatskevich. All rights reserved.
//

public
typealias GlobalEntityId = String

//---

public
typealias EntityId = String

//---

public
protocol IdentifiableEntity
{
    var enm_entityId: EntityId { get }
}
//---

private
func getGlobalId<T: IdentifiableEntity>(for entity: T) -> GlobalEntityId
{
    // system-wide unique key
    
    return "\(String(reflecting: type(of: entity)))::\(entity.enm_entityId)"
}

//---

public
protocol Entity: IdentifiableEntity
{
    var enm_globalId: GlobalEntityId { get }
}

public
extension Entity
{
    var enm_globalId: GlobalEntityId
    {
        return getGlobalId(for: self)
    }
}

//---

public
struct Weak<T: AnyObject>
{
    public private(set)
    weak var value: T?
    
    public
    init(_ value: T?)
    {
        self.value = value
    }
}

//---

public
enum EntityManager
{
    private
    static
    var wrappers: [Weak<AnyObject>] = []
    
    //---
    
    public
    static
    func wrap<T: Entity>(_ entity: T) -> EntityWrapper<T>
    {
        // cleanup first
        
        wrappers = wrappers.filter({ $0.value != nil })
        
        //---
        
        if
            let existingWrapper =
                wrappers
                    .compactMap({ $0.value as? Entity })
                    .filter({ $0.enm_globalId == entity.enm_globalId })
                    .compactMap({ $0 as? EntityWrapper<T>})
                    .first
        {
            existingWrapper.entity = entity // update entity
            
            //---
            
            return existingWrapper
        }
        else
        {
            let newWrapper = EntityWrapper(entity)
            
            //---
            
            wrappers.append(
                Weak(newWrapper)
            )
            
            //---
            
            return newWrapper
        }
    }
}

//---

public
final
class EntityWrapper<T: Entity>: Entity
{
    // Entity is recommendet to be immutable
    
    public
    var enm_globalId: GlobalEntityId
    {
        return entity.enm_globalId
    }
    
    public
    var enm_entityId: EntityId
    {
        return entity.enm_entityId
    }
    
    public
    var entity: T
    
    //---
    
    fileprivate
    init(_ entity: T)
    {
        self.entity = entity
    }
}
