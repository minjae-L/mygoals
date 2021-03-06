//
//  ViewController.swift
//  goalsApp
//
//  Created by 이민재 on 2021/05/22.
//  Copyright © 2021 이민재. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    var titleArr = [String]()
    
    // firebase
    var db = Firestore.firestore()
    
    // 일정 불러오기
    func loadGoals() {
        db.collection("goals").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.titleArr.append(document.documentID)
                }
                    self.scheduleTableView.reloadData()
            }
        }
    }
    
    //add뷰에서 보낸 일정을 받는 함수
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc2 = segue.destination as? AddViewController {
            vc2.delegate = self
        }
    }
    
    // 일정추가 텍스트 설정 함수
    func setupMessageLabel(label: UILabel) {
        label.font.withSize(20)
        label.text = "일정을 추가해주세요."
        label.textColor = UIColor.lightGray
    }
    
    
    
    // 테이블 뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScheduleTableViewCell = scheduleTableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        cell.titleLabel.text = titleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = storyboard?.instantiateViewController(identifier: "GoalViewController") as? GoalViewController else { return }
        
        db.collection("goals").document("\(titleArr[indexPath.row])").getDocument { (querySnapshot, err) in
            if let err = err {
                print("Error getting Documents: \(err)")
            } else {
                if let discText = querySnapshot?.get("discription") as? String {
                        vc.discriptionText = discText
                    vc.discriptionTextView.text = discText
                }
                if let proceedBool = querySnapshot?.get("isProceeding") as? Bool {
                        vc.isProceedingBool = proceedBool
                    if proceedBool == true {
                        vc.startButton.setTitle("진행중", for: .normal)
                    } else {
                        vc.startButton.setTitle("시작하기", for: .normal)
                    }
                }
            }
        }
        vc.titleText = titleArr[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func viewDidLoad() {
        loadGoals()
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        if titleArr.isEmpty {
            setupMessageLabel(label: messageLabel)
        } else {
            messageLabel.text = ""
        }
        super.viewDidLoad()
    }
}

