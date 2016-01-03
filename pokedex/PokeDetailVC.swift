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
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var hpLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var evoPresentImg: UIImageView!
    @IBOutlet weak var evoNextImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = detiPokemon.name.capitalizedString
        mainImg.image = detiPokemon.pokemonImg
        pokeIdLbl.text = detiPokemon.pokedexId
    }


    //MARK: Action
    @IBAction func backBtnPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
}








