//
//  GoalViewController.swift
//  goalsApp
//
//  Created by 이민재 on 2021/07/02.
//  Copyright © 2021 이민재. All rights reserved.
//

import UIKit
import Firebase

class GoalViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBAction func start(_ sender: Any) {
        print(startButton.currentTitle)
    }
    
    // 파베로부터 불러올 데이터들
    var titleText: String?
    var discriptionText: String?
    var isProceedingBool: Bool?
    
    
    // firebase
    let db = Firestore.firestore()
    
    //UIButton
    func setBtn() {
        startButton.backgroundColor = .systemBlue
        startButton.titleColor(for: .focused)
        startButton.titleLabel?.tintColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        titleLabel.text = titleText
        setBtn()
        super.viewDidLoad()


    }
}
