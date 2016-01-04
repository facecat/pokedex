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
    private var _description: String!
    private var _evoId: String!
    private var _evoLvl: String!
    private var _evoTxt: String!
    
    var evoTxt: String {
//        if _evoTxt == nil {
//            return ""
//        }
        return _evoTxt == nil ? "" : _evoTxt
    }
    
    var evoLvl: String {
//        if _evoLvl == nil {
//            return ""
//        }
        return _evoLvl == nil ? "" : _evoLvl
    }
    
    var evoId: String {
//        if _evoId == nil {
//            return ""
//        }
        return _evoId == nil ? "" : _evoId
    }
    
    var description: String {
//        if _description == nil {
//            return ""
//        }
        return _description == nil ? "" : _description
    }
    
    var height: String {
//        if _height == nil {
//            return ""
//        }
        return _height == nil ?  "" : _height
    }
    
    var weight: String {
//        if _weight == nil {
//            return ""
//        }
        return _weight == nil ? "" : _weight
    }
    
    var defense: String {
//        if _defense == nil {
//            return ""
//        }
        return _defense == nil ? "" : _defense
    }
    
    var attack: String {
//        if _attack == nil {
//            return ""
//        }
        return _attack == nil ? "" : _attack
    }
    
    var speed: String {
//        if _speed == nil {
//            return ""
//        }
        return _speed == nil ? "" : _speed
    }
    
    var hp: String {
//        if _hp == nil {
//            return ""
//        }
        return _hp == nil ? "" : _hp
    }
    
    var type: String {
//        if _type == nil {
//            return ""
//        }
        return _type == nil ? "" : _type
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
//                    print(self._height)
//                    print(self._defense)
//                    print(self._attack)
//                    print(self._hp)
//                    print(self._speed)
//                    print(self._weight)
                    
                    if let typeArray = dict["types"] as? [Dictionary<String, String>] where typeArray.count > 0{
                        var type = typeArray[0]["name"]!
                        
                        for i in 1..<typeArray.count {
                            let addOne = typeArray[i]["name"]!
                            type += "/\(addOne)"
                        }
                        self._type = type
                    }
//                    print(self._type)
                    
                    //download evoImg
                    if let evoArray = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evoArray.count > 0{
                        
                        if let to = evoArray[0]["to"] as? String {
                            if to.rangeOfString("mega") == nil {
                                
                                self._evoTxt = to
                                
                                if let evoUri = evoArray[0]["resource_uri"] as? String {
                                    let evoStr = evoUri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    let evoId = evoStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    self._evoId = evoId
                                }
                                
                                if let lvl = evoArray[0]["level"] as? Int {
                                    self._evoLvl = "\(lvl)"
                                }
                            }
                        }
                    }
                    
                    //description
                    if let descArray = dict["descriptions"] as? [Dictionary<String, String>] where descArray.count > 0 {
                        if let descUri = descArray[0]["resource_uri"] {

                            if let url = NSURL(string: "\(URL_BASE)\(descUri)") {
                                
                                Alamofire.request(.GET, url).responseJSON { (response: Response<AnyObject, NSError>) -> Void in
                                    if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                        if let pokemonDesc = descDict["description"] as? String {
                                            self._description = pokemonDesc
//                                            print(pokemonDesc)
                                        }
                                    }
                                    completed()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
}







