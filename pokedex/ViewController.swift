//
//  ViewController.swift
//  pokedex
//
//  Created by 邱国邦 on 15/12/30.
//  Copyright © 2015年 FaceCat. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var pokemon = [Pokemon]()
    
    var avplayer: AVAudioPlayer!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview.dataSource = self
        collectionview.delegate = self
        
        loadCsvFile()
        setupBackgroundMusic()
    }
    
    func setupBackgroundMusic() {
        if let url = NSBundle.mainBundle().URLForResource("music", withExtension: "mp3") {
            do {
                avplayer = try AVAudioPlayer(contentsOfURL: url)
                
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
    
    
    //MARK: Action
    @IBAction func musicBtnPressed() {
        if avplayer.playing {
            avplayer.stop()
        } else {
            avplayer.play()
        }
    }
    
    
    
    
}





