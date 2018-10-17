//
//  TempleListViewController.swift
//  Project 2 Sou Mizobuchi
//
//  Created by user144546 on 10/12/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import UIKit

class TempleListViewController: UIViewController {
    
    // Mark - Constants
    private struct storyBoard {
        static let templeTableRowIdentifier = "TempleTableRowIdentifier"
        static let templeCardIdentifier = "TempleCardIdentifier"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension TempleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TempleDeck.temples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyBoard.templeCardIdentifier, for: indexPath)
        if let templeCard = cell as? TempleCardView {
            // something
        }
        
        return cell
    }
}

extension TempleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TempleDeck.temples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.templeTableRowIdentifier, for: indexPath)
        cell.textLabel?.text = TempleDeck.temples[indexPath.row].name
        
        return cell
    }
}
