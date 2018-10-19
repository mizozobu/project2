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
    
    // Mark - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UIBarButtonItem!
    @IBOutlet weak var modeButton: UIBarButtonItem!
    
    @IBAction func toggleMode(_ sender: Any) {
        collectionView.layoutIfNeeded()
        let templeCardView = TempleCardView()
        
        if tableViewWidth.constant > 0 {
            tableViewWidth.constant = 0
            modeButton.title = "Play"
            templeCardView.isStudyMode = true
        } else {
            tableViewWidth.constant = 250
            modeButton.title = "Study"
            templeCardView.isStudyMode = false
        }
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func refresh(_ sender: Any) {
        templeDeck = TempleDeck()
        self.matchCount = 0
        updateScore()
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    // Mark - Properties
    var templeDeck = TempleDeck()
    var selectedTempleName = "tmeplename"
    var selectedTempleImageName = "templeimagename"
    var matchCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Mark - Helpers
    func removeItem(indexPath: IndexPath) {
        self.templeDeck.temples.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.matchCount += 1
        updateScore()
    }
    
    func updateScore() {
        self.scoreLabel.title = "Score: \(self.matchCount)"
    }
}

extension TempleListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return templeDeck.temples.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: storyBoard.templeCardIdentifier, for: indexPath)
        let temple = templeDeck.temples[indexPath.row]
        
        if let templeCard = cell as? TempleCardCell {
            templeCard.templeCardView.temple = temple
        }
        
        return cell
    }
}

extension TempleListViewController: UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let image = UIImage(named: templeDeck.temples[indexPath.row].filename) {
            return CGSize(width: image.size.width / image.size.height * 100, height: 100)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTempleImageName = templeDeck.temples[indexPath.row].name
        
        if self.selectedTempleName == self.selectedTempleImageName {
            removeItem(indexPath: indexPath)
        }
    }
}

extension TempleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templeDeck.temples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storyBoard.templeTableRowIdentifier, for: indexPath)
        
        cell.textLabel?.text = templeDeck.temples[indexPath.row].name
        
        return cell
    }
}

extension TempleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTempleName = templeDeck.temples[indexPath.row].name
        
        if self.selectedTempleName == self.selectedTempleImageName {
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.performBatchUpdates({
                removeItem(indexPath: indexPath)
            })
        }
    }
}
