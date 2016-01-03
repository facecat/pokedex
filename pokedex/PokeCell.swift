//
//  PokeCell.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/31.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    private var _poke: Pokemon!
    
    func configureCell(poke: Pokemon) {
        _poke = poke
        
        mainImg.image = _poke.pokemonImg
        nameLbl.text = _poke.name.capitalizedString
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }

    

}
