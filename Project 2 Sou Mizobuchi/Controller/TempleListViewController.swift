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
    @IBOutlet weak var regreshButton: UIBarButtonItem!
    @IBOutlet weak var socreButton: UIBarButtonItem!
    
    @IBAction func toggleMode(_ sender: Any) {
        collectionView.layoutIfNeeded()
        self.isStudyMode = !self.isStudyMode
        regreshButton.isEnabled = !self.isStudyMode
        socreButton.isEnabled = !self.isStudyMode
        tableViewWidth.constant = self.isStudyMode ? 0 : 250
        modeButton.title = self.isStudyMode ? "Match" : "Study"
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: {
            _ in
            self.toggleLabelForAll()
        })
    }
    
    @IBAction func refresh(_ sender: Any) {
        templeDeck = TempleDeck()
        self.attemptCount = 0
        self.matchCount = 0
        updateScore()
        collectionView.reloadData()
        tableView.reloadData()
    }
    
    // Mark - Properties
    var templeDeck = TempleDeck()
    var selectedTempleName = ""
    var selectedTempleImageName = ""
    var isStudyMode = false
    var attemptCount = 0
    var matchCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Mark - Helpers
    func showMessage(msg: String) {
        let alert = UIAlertController(title: msg, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func removeItem(indexPath: IndexPath) {
        self.templeDeck.temples.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.matchCount += 1
        self.selectedTempleImageName = ""
        self.selectedTempleName = ""
        updateScore()
    }
    
    func updateScore() {
        self.scoreLabel.title = "Score: \(self.matchCount) Attempts: \(self.attemptCount)"
    }
    
    func addAttempleCount() {
        if self.selectedTempleImageName != "" && self.selectedTempleName != "" {
            self.attemptCount += 1
            self.updateScore()
        }
    }
    
    func toggleLabelForAll() {
        for i in 0...templeDeck.temples.count - 1 {
            let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0))
            if let templeCardCell = cell as? TempleCardCell {
                templeCardCell.templeCardView.isStudyMode = self.isStudyMode
                templeCardCell.templeCardView.setNeedsDisplay()
            }
        }
    }
    
    func changeBorderColorAtIndex(indexPath: IndexPath, color: UIColor) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let templeCardCell = cell as? TempleCardCell {
            templeCardCell.templeCardView.borderColor = color
            templeCardCell.templeCardView.setNeedsDisplay()
        }
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
            // set cell width based on image size to keep image proportion
            return CGSize(width: image.size.width / image.size.height * 100, height: 100)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedTempleImageName = templeDeck.temples[indexPath.row].name
        self.addAttempleCount()
        
        // reset border color
        for i in 0...templeDeck.temples.count - 1 {
            let indexPath = IndexPath(row: i, section: 0)
            changeBorderColorAtIndex(indexPath: indexPath, color: UIColor.blue)
        }
        
        if !self.isStudyMode {
            // change border color for selected item
            changeBorderColorAtIndex(indexPath: indexPath, color: UIColor.green)
            
            // show popup message
            if self.selectedTempleImageName != "" && self.selectedTempleName != "" {
                if self.selectedTempleName == self.selectedTempleImageName {
                    removeItem(indexPath: indexPath)
                    self.showMessage(msg: "Correct")
                }
                else {
                    self.showMessage(msg: "Incorrect")
                }
            }
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
        self.addAttempleCount()
        
        if self.selectedTempleImageName != "" && self.selectedTempleName != "" {
            if self.selectedTempleName == self.selectedTempleImageName {
                tableView.deselectRow(at: indexPath, animated: true)
                tableView.performBatchUpdates({
                    removeItem(indexPath: indexPath)
                    showMessage(msg: "Correct")
                })
            }
            else {
                showMessage(msg: "Incorrect")
            }
        }
    }
}
