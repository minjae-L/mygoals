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
    var titleText: String?
    @IBOutlet weak var testLabel: UILabel!
    
    // 목표 제목 로드
    func setGoal() {
            self.testLabel.text = titleText
    }

    override func viewDidLoad() {
        print(titleText)
        setGoal()
        super.viewDidLoad()


    }
}
