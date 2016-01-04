//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by 邱国邦 on 16/1/3.
//  Copyright © 2016年 FaceCat. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    var pokemon: Pokemon!
    
    //MARK: Outlet
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var pokeIdLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var evoPresentImg: UIImageView!
    @IBOutlet weak var evoNextImg: UIImageView!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLocalValue()
        downloadDetialValue()
    }

    func setLocalValue() {
        nameLbl.text = pokemon.name.capitalizedString
        pokeIdLbl.text = pokemon.pokedexId
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        evoPresentImg.image = mainImg.image
    }
    
    func downloadDetialValue() {
        
        pokemon.downloadPokemonDetail { () -> () in
            
            self.attackLbl.text = self.pokemon.attack
            self.defenseLbl.text = self.pokemon.defense
            self.hpLbl.text = self.pokemon.hp
            self.speedLbl.text = self.pokemon.speed
            self.weightLbl.text = self.pokemon.weight
            self.heightLbl.text = self.pokemon.height
            self.typeLbl.text = self.pokemon.type
            self.descLbl.text = self.pokemon.description
            
            
            if self.pokemon.evoTxt == ""{
                self.evoLbl.text = "No Evolution"
                self.evoNextImg.hidden = true
            } else {
                self.evoNextImg.hidden = false
                self.evoNextImg.image = UIImage(named: self.pokemon.evoId)
                
                var txt = "Next Evolution"
                
                if self.pokemon.evoLvl != "" {
                    txt += " - LVL  \(self.pokemon.evoLvl)"
                }
                self.evoLbl.text = txt
            }
            
        }
    }

    //MARK: Action
    @IBAction func backBtnPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}








