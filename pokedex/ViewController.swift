//
//  ViewController.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/30.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UISearchBarDelegate {

    var pokemon = [Pokemon]()
    var searchPokemon = [Pokemon]()
    var isSearching = false

    var avplayer: AVAudioPlayer!
    
    //MARK: Outlet
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        searchBar.delegate = self
        
        loadCsvFile()
        setupBackgroundMusic()
    }
    
    func setupBackgroundMusic() {
        if let url = NSBundle.mainBundle().URLForResource("music", withExtension: "mp3") {
            do {
                avplayer = try AVAudioPlayer(contentsOfURL: url)

                avplayer.numberOfLoops = -1
                avplayer.prepareToPlay()
                avplayer.play()
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
    }
    
    func loadCsvFile() {
        if let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                
                let row = csv.rows      // row is an NEW array indices from 0 to cow.count-1.
                for i in 0..<row.count {
                    let name = row[i]["identifier"]!
                    let id = row[i]["id"]!
                    print("\(name)\(id)")
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
        
        if isSearching {
            return searchPokemon.count
        }
        
        return pokemon.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionview.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            let poke: Pokemon!
            
            if isSearching {
                poke = searchPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
        
            cell.configureCell(poke)
//            print("configureCell")
//            print(poke.name)
//            print(poke.pokedexId)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // to detail view
        // need web request ...
        let poke: Pokemon!
        if isSearching {
            poke = searchPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegueWithIdentifier("PokeDetailVC", sender: poke)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(106, 106)
    }
    
    
    //MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokeDetailVC" {

            if let controller = segue.destinationViewController as? PokeDetailVC {
                if let poke = sender as? Pokemon {
                    controller.pokemon = poke
                }
            }
        }
    }
    
    
    //MARK: UISearchBarDelegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil {
            isSearching = false
            
            view.endEditing(true)
            
        } else {
            isSearching = true
            
            let lower = searchBar.text!.lowercaseString
            searchPokemon = pokemon.filter({ $0.name.rangeOfString(lower) != nil })
//            print("\(searchPokemon.count)")
        }
        
        collectionview.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //MARK: Action
    @IBAction func musicBtnPressed() {
        if avplayer.playing {
            avplayer.stop()
        } else {
            avplayer.play()
        }
    }
    
    
    
    
}





