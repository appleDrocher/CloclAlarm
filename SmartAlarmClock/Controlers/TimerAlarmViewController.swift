//
//  TimerAlarmViewController.swift
//  SmartAlarmClock
//
//  Created by Урутян Левон on 09.02.2024.
//

import UIKit

class TimerAlarmViewController: UIViewController {
    
        let content = UIView()
      
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            

            let button1 = CreateButton()
            
            view.addSubview(content)
            content.addSubview(button1)
        
            
            content.layout
                .box(in: view)
                .activate()
           
            
            button1.layout
                .leading(28)
                .trailing(28)
                .height(80)
                .top(600)
                .activate()
            
        }
        
        
    }
