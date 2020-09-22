//
//  ViewController.swift
//  SwipeCards
//
//  Created by VJ's iMAC on 22/09/20.
//  Copyright © 2020 VJ's. All rights reserved.
//

import UIKit
import Shuffle_iOS
import ObjectMapper

class ViewController: UIViewController {
    
    @IBOutlet weak var stackSwipeView: SwipeCardStack!
    
    var allCards : [Cards?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryService()
        view.addSubview(stackSwipeView)
        stackSwipeView.delegate      = self
        stackSwipeView.dataSource    = self
        // Do any additional setup after loading the view.
    }
    
    @objc func leftButtonTapped() {
        
        stackSwipeView?.reloadData()
        
    }
    
    @objc func rightButtonTapped() {
        
        stackSwipeView?.swipe(.right, animated: true)
        
    }
    
    @objc func undoButtonTapped() {
        stackSwipeView.undoLastSwipe(animated: true)
    }
    
    
    
    
}

extension ViewController : SwipeCardStackDelegate,SwipeCardStackDataSource {
    func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
        return getSwipeView(cardStack, viewForCardAt: index)
    }
    
    func numberOfCards(in cardStack: SwipeCardStack) -> Int {
        return self.allCards.count
    }
    func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
        print("Undo \(direction) swipe on")
    }
    func didSwipeAllCards(_ cardStack: SwipeCardStack) {
        print("Swiped all cards!")
    }
    func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
        print("Card tapped")
    }
    
}

extension ViewController {
    func getSwipeView(_ koloda: SwipeCardStack, viewForCardAt index: Int) -> SwipeCard {
        let customview  = CustomView()
        let allCard = allCards[index]
        customview.idLabel.text = allCard?.id
        customview.titleLabel.text = allCard?.text
        customview.indexLabel.text = "Current Index Number is : \(index + 1)"
        customview.nextButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        customview.previousButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        customview.restoreButton.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        return customview
    }
    
    
}


extension ViewController {
    func categoryService(){
        
        if let path = Bundle.main.path(forResource: "AllMenu", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                guard let jsonObj = jsonResult as? [String: AnyObject] else {
                    return print("handle error")
                }
                print(jsonObj)
                if let data = (jsonObj as NSDictionary).value(forKey: "data") as? NSArray {
                    let result = Mapper<Cards>().mapArray(JSONObject: data)
                    result?.forEach({allCards.append($0)})
                    
                }
            } catch {
                
                print("handle error")
            }
        }
    }
    
}
