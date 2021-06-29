//
//  ViewController.swift
//  goalsApp
//
//  Created by 이민재 on 2021/05/22.
//  Copyright © 2021 이민재. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scheduleTableView: UITableView!
    var titleArr = [String]()
    
    // add뷰에서 보낸 일정을 받는 함수
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
    
    
    override func viewDidLoad() {
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        if titleArr.isEmpty {
            setupMessageLabel(label: messageLabel)
        }
        super.viewDidLoad()
    }


}

