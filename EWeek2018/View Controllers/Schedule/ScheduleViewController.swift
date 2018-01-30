//
//  ScheduleViewController.swift
//  EWeek2018
//
//  Created by Aashima Garg on 12/26/17.
//  Copyright © 2017 SEC. All rights reserved.
//

import UIKit

// Below import statements
class Responder: NSObject {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        UIView.animate(withDuration: 0.3) {
            buttonBar.frame.origin.x = (segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)) * CGFloat(segmentedControl.selectedSegmentIndex)
    }

}
let responder = Responder()
let buttonBar = UIView()
class ScheduleViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
                "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
                "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
                "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
                "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "eventcell")
        tableView.register(UINib(nibName: "DateCell", bundle: nil), forCellReuseIdentifier: "datecell")
        
        segmentedControl.backgroundColor = .clear
       
        segmentedControl.tintColor = .clear
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        segmentedControl.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.black
            ], for: .selected)
        // This needs to be false since we are using auto layout constraints
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = UIColor.purple
        view.addSubview(buttonBar)
        // Constrain the top of the button bar to the bottom of the segmented control
        buttonBar.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        // Constrain the button bar to the width of the segmented control divided by the number of segments
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
        
        // let font = UIFont.systemFont(ofSize: 20)
        // let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        // UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        // segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        // Do any additional setup after loading the view, typically from a nib.
        segmentedControl.addTarget(responder, action: #selector(responder.segmentedControlValueChanged(_:)), for: UIControlEvents.valueChanged)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row % 5 == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datecell", for: indexPath) as! DateCell
            return cell;
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventcell", for: indexPath) as! EventCell
            return cell;
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

}

