//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Estuardo Morales on 11/4/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import UIKit

class PokeCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage()
    }
}
