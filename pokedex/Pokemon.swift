//
//  Pokemon.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/31.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: String!
    private var _type: String!
    private var _hp: String!
    private var _speed: String!
    private var _attack: String!
    private var _defense: String!
    private var _pokeUrl: String!
    private var _weight: String!
    private var _height: String!
    
    var height: String {
        return _height
    }
    
    var weight: String {
        return _weight
    }
    
    var defense: String {
        return _defense
    }
    
    var attack: String {
        return _attack
    }
    
    var speed: String {
        return _speed
    }
    
    var hp: String {
        return _hp
    }
    
    var type: String {
        return _type
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: String {
        return _pokedexId
    }
    
    
    init(name: String, pokedexId: String) {
        _name = name
        _pokedexId = pokedexId
        _pokeUrl = "\(URL_BASE)\(URL_API_V1)\(_pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        if let url = NSURL(string: _pokeUrl) {
            Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    
                    if let hp = dict["hp"] as? Int {
                        self._hp = "\(hp)"
                    }
                    
                    if let speed = dict["speed"] as? Int {
                        self._speed = "\(speed)"
                    }
                    
                    if let attack = dict["attack"] as? Int {
                        self._attack = "\(attack)"
                    }
                    
                    if let defense = dict["defense"] as? Int {
                        self._defense = "\(defense)"
                    }
                    
                    if let weight = dict["weight"] as? String {
                        self._weight = weight
                    }
                    
                    if let height = dict["height"] as? String {
                        self._height = height
                    }
                    //debuging
                    print(self._height)
                    print(self._defense)
                    print(self._attack)
                    print(self._hp)
                    print(self._speed)
                    print(self._weight)
                    
                    if let typeArray = dict["types"] as? [Dictionary<String, String>] where typeArray.count > 0{
                        var type = typeArray[0]["name"]!
                        
                        for i in 1..<typeArray.count {
                            let addOne = typeArray[i]["name"]!
                            type += "/\(addOne)"
                        }
                        self._type = type
                    }
                    print(self._type)
                    
                    //description not finished
                    
                    completed()
                }
            }
        }
    }
}





