//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by 邱国邦 on 16/1/3.
//  Copyright © 2016年 FaceCat. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    var detiPokemon: Pokemon!
    
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
        nameLbl.text = detiPokemon.name.capitalizedString
        pokeIdLbl.text = detiPokemon.pokedexId
        mainImg.image = UIImage(named: "\(detiPokemon.pokedexId)")
        evoPresentImg.image = mainImg.image
    }
    
    func downloadDetialValue() {
        
        detiPokemon.downloadPokemonDetail { () -> () in
            
            self.attackLbl.text = self.detiPokemon.attack
            self.defenseLbl.text = self.detiPokemon.defense
            self.hpLbl.text = self.detiPokemon.hp
            self.speedLbl.text = self.detiPokemon.speed
            self.weightLbl.text = self.detiPokemon.weight
            self.heightLbl.text = self.detiPokemon.height
            self.typeLbl.text = self.detiPokemon.type
            self.descLbl.text = self.detiPokemon.description
        }
    }

    //MARK: Action
    @IBAction func backBtnPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}








