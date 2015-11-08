//
//  Pokemon.swift
//  pokedex
//
//  Created by Estuardo Morales on 11/4/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    private var _pokemonUrl: String!
    
    var name: String {
       
            if _name == nil {
                _name = ""
            }
            
            return _name
       
    }
    
    var pokedexId: Int {
       
            if _pokedexId == nil {
                _pokedexId = 0
            }
            
            return _pokedexId
       
    }
    
    var description: String {
       
            if _description == nil {
                _description = ""
            }
            return _description
       
    }
    
    var type: String {
       
            if _type == nil {
                _type = ""
            }
            
            return _type
       
    }
    
    var defense: String {
       
            if _defense == nil {
                _defense = ""
            }
            
            return _defense
       
    }
    
    var height: String {
       
            if _height == nil {
                _height = ""
            }
            
            return _height
       
    }
    
    var attack: String {
   
            if _attack == nil {
                _attack = ""
            }
            
            return _attack
   
    }
    
    var weight: String {
   
            if _weight == nil {
                _weight = ""
            }
            
            return _weight
   
    }
    
    var nextEvolutionText: String {
       
            if _nextEvolutionText == nil {
                _nextEvolutionText = ""
            }
            
            return _nextEvolutionText
       
    }
    
    var nextEvolutionId: String {
       
            if _nextEvolutionId == nil {
                _nextEvolutionId = ""
            }
            
            return _nextEvolutionId
       
    }
    
    var nextEvolutionLevel: String {
        get {
            if _nextEvolutionLevel == nil {
                _nextEvolutionLevel = ""
            }
            
            return _nextEvolutionLevel
        }
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails (completed: DownloadComplete) {
        let url = self._pokemonUrl!
        
        Alamofire.request(.GET, url).responseJSON { response in
            if let JSON = response.result.value  as? Dictionary<String, AnyObject> {
                if let  weight = JSON["weight"] as? String {
                    self._weight = weight
                }
                if let  height = JSON["height"] as? String {
                    self._height = height
                }
                if let  attack = JSON["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let  defense = JSON["defense"] as? Int {
                    self._defense = "\(defense)"
                }

                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)

                if let types = JSON["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = JSON["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let resourceUrl = descArr[0]["resource_uri"] {
                        let nsUrl = "\(URL_BASE)\(resourceUrl)"
                        Alamofire.request(.GET, nsUrl).responseJSON { response in
                            
                            if let desDict = response.result.value as? Dictionary<String, AnyObject>  {
                                if let description = desDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            
                            completed()
                            
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = JSON["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    if let to = evolutions[0]["to"] as? String {
                        
                        // Can't support mega pokemon right now but api still has mega data
                        if to.rangeOfString("mega") == nil {
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionText = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvolutionLevel = "\(lvl)"
                                }
                                
                                print(self._nextEvolutionId)
                                print(self._nextEvolutionText)
                                print(self._nextEvolutionLevel)
                                
                            }
                        }
                    }
                }
                
            }
        }
    }
}