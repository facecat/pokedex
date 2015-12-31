//
//  ViewController.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/30.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var pokemon = [Pokemon]()
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        
        let p1 = Pokemon(name: "Who Am I?", pokedexId: "200")
        let p2 = Pokemon(name: "I am NOBODY", pokedexId: "300")
        let p3 = Pokemon(name: "OH SHOOT", pokedexId: "400")
        pokemon.append(p1)
        pokemon.append(p2)
        pokemon.append(p3)
        collectionview.reloadData()
        
        loadCsvFile()
    }
    
    func loadCsvFile() {
        if let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                print(csv.delimiter)
                //from here ....
                let row = csv.rows
                for i in 1...row.count {
                    let name = row[i]["identifier"]!
                    let id = row[i]["id"]!
                    let poke = Pokemon(name: name, pokedexId: id)
                    pokemon.append(poke)
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
       
    }


    //MARK: UICollectionViewDelegate & DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionview.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(106, 106)
    }
}





