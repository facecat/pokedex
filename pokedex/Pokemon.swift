//
//  Pokemon.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/31.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: String!
    private var _pokemonImg: UIImage!
    private var _type: String!
    private var _hp: String!
    private var _speed: String!
    private var _attack: String!
    private var _defence: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: String {
        return _pokedexId
    }
    
    var pokemonImg: UIImage {
        return _pokemonImg
    }
    
    
    
    
    init(name: String, pokedexId: String) {
        _name = name
        _pokedexId = pokedexId
        _pokemonImg = UIImage(named: _pokedexId)
    }
}





