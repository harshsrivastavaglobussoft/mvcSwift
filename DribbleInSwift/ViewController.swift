//
//  ViewController.swift
//  DribbleInSwift
//
//  Created by Sumit Ghosh on 07/08/17.
//  Copyright © 2017 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var PopularTableView: UITableView!
    @IBOutlet var PopularView: UIView!
    @IBOutlet var TimeView: UIView!
    @IBOutlet var TimeTableView: UITableView!
    @IBOutlet var ReboundView: UIView!
    @IBOutlet var ReboundTableView: UITableView!
    
    var PopualarDataArray:NSArray!
    var TimeDataArray:NSArray!
    var ReboundDataArray:NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        ReboundData.init().getDataForReboundTable { (data) in
            self.ReboundDataArray=data
            self.forReboundTable()
        }
        
        PopularData.init().getDataForPopularTable { (data) in
            self.PopualarDataArray=data
            self.forPopularTable()
        }
        
        TimeData.init().getDataForTimeTable { (data) in
            self.TimeDataArray=data
            self.forTimeTable()
        }
    }
    func forReboundTable() -> Void {
        self.ReboundTableView.delegate=self;
        self.ReboundTableView.dataSource=self;
        self.ReboundTableView .reloadData()
    }
    
    func forTimeTable() ->Void {
        self.TimeTableView.delegate=self
        self.TimeTableView.dataSource=self
        self.TimeTableView.reloadData()
    }
    
    func forPopularTable() -> Void {
        self.PopularTableView.dataSource=self
        self.PopularTableView.delegate=self
        self.PopularTableView.reloadData()
    }
    
    @IBAction func ChangeView(_ sender: Any) {
        switch self.segmentController.selectedSegmentIndex
        {
        case 0:
            self.PopularView.isHidden=false
            self.TimeView.isHidden=true
            self.ReboundView.isHidden=true
            break
        case 1:
            self.TimeView.isHidden=false
            self.PopularView.isHidden=true
            self.ReboundView.isHidden=true
            break
        case 2:
            self.ReboundView.isHidden=false
            self.PopularView.isHidden=true
            self.TimeView.isHidden=true
            break
        default:
            break; 
        }
        
}
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==self.PopularTableView {
            return self.PopualarDataArray.count
        }else if tableView==self.TimeTableView{
            return self.TimeDataArray.count
        }else{
            return self.ReboundDataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        
        var cell:CustomTableViewCell=(tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableViewCell)!
        if cell==nil {
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = (tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableViewCell)!
        }
        if tableView==self.PopularTableView {
            let dataDict = self.PopualarDataArray[indexPath.row] as! NSDictionary
            
            let dataUser=[dataDict .object(forKey: "user")]as Any as!NSDictionary
            
            let name = [dataUser .object(forKey: "name")]
            
            let location = [dataUser .object(forKey: "location")]
            
            
             cell.picDetailsLabel.text="\(name)\(location)"
        }
        else if tableView==self.TimeTableView{
            let dataDict = self.TimeDataArray[indexPath.row] as! NSDictionary
            
            let dataUser=[dataDict .object(forKey: "user")]as Any as!NSDictionary
            
            let name = [dataUser .object(forKey: "name")]
            
            let location = [dataUser .object(forKey: "location")]
            
            
            cell.picDetailsLabel.text="\(name)\(location)"
        }else{
            let dataDict = self.ReboundDataArray[indexPath.row] as! NSDictionary
            
            let dataUser=[dataDict .object(forKey: "user")]as Any as!NSDictionary
            
            let name = [dataUser .object(forKey: "name")]
            
            let location = [dataUser .object(forKey: "location")]
            
            
            cell.picDetailsLabel.text="\(name)\(location)"
        }
        
        
      return cell
    }
    
    
}
