//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Estuardo Morales on 11/5/15.
//  Copyright © 2015 Estuardo Morales. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    var pokemon: Pokemon!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        currentEvoImage.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            self.updateIU()
        }
    }
    
    func updateIU() {
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        baseAttackLabel.text = pokemon.attack
        
        if pokemon.nextEvolutionId == "" {
            evoLabel.text = "No Evolution"
            nextEvoImage.hidden = true
        } else {
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel == "" {
                str += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            
            evoLabel.text = str
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
