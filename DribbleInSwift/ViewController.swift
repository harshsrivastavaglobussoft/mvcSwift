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
        
        self.forReboundTable()
        self.forPopularTable()
        self.forTimeTable()
    
        
        
        ReboundData.init().getDataForReboundTable { (data) in

            DispatchQueue.main.async {
                self.ReboundDataArray=data
                self.ReboundTableView.reloadData()
            }
          
        }
        
        PopularData.init().getDataForPopularTable { (data) in

            DispatchQueue.main.async {
                self.PopualarDataArray=data
                self.PopularTableView.reloadData()
           }
        }
        
        TimeData.init().getDataForTimeTable { (data) in

            DispatchQueue.main.async {
                self.TimeDataArray=data
                self.TimeTableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
    func forReboundTable() -> Void {
        self.ReboundTableView.delegate=self;
        self.ReboundTableView.dataSource=self;
        self.ReboundTableView.backgroundColor=UIColor.gray
        
        
    }
    
    func forTimeTable() ->Void {
        self.TimeTableView.delegate=self
        self.TimeTableView.dataSource=self
        self.TimeTableView.backgroundColor=UIColor.brown
        
    }
    
    func forPopularTable() -> Void {
        self.PopularTableView.dataSource=self
        self.PopularTableView.delegate=self
        self.PopularTableView.backgroundColor=UIColor.blue
        
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
            if self.PopualarDataArray==nil {
                return 0
            }else{
            return self.PopualarDataArray.count
            }
        }else if tableView==self.TimeTableView{
            if self.TimeDataArray==nil{
                return 0
            }else{
            return self.TimeDataArray.count
            }
        }else{
            if self.ReboundDataArray==nil {
                return 0
            }else{
            return self.ReboundDataArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let identifier = "cell"
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        let cell:CustomTableViewCell=(tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomTableViewCell)!
        
        if tableView==self.PopularTableView {
            let dataDict = self.PopualarDataArray[indexPath.row] as! NSDictionary
            
            let dataUser = dataDict["user"]as! NSDictionary
            
            let name = dataUser["name"]as! NSString
            
            let location = dataUser["location"]as! NSString
            
            let ImageDict = dataDict["images"]as! NSDictionary
            
            let ImageUrlString = ImageDict["teaser"]as! NSString
            
            //async downloading of image
            DispatchQueue.global().async(execute: { () -> Void in
                
            let imageUrl: URL = URL.init(string: ImageUrlString as String)!
            //converting it to nsdata
            let data = NSData (contentsOf: imageUrl)
             //getting it back to main thread
            DispatchQueue.main.async{
            cell.dribbleImageView.image = UIImage(data:data! as Data)
            }
                
            })
            
            cell.picDetailsLabel.text="\(name)\(location)"
        }
        else if tableView==self.TimeTableView{
            let dataDict = self.TimeDataArray[indexPath.row] as! NSDictionary
            
            let dataUser = dataDict["user"]as! NSDictionary
            
            let name = dataUser["name"]as! NSString
            
            let location = dataUser["location"]as! NSString
            
            let ImageDict = dataDict["images"]as! NSDictionary
            
            let ImageUrlString = ImageDict["teaser"]as! NSString
            
            
            DispatchQueue.global().async(execute: { () -> Void in

            let imageUrl: URL = URL.init(string: ImageUrlString as String)!
            let data = NSData (contentsOf: imageUrl)
                DispatchQueue.main.async{
            cell.dribbleImageView.image = UIImage(data:data! as Data)
                }
            })
            
            cell.picDetailsLabel.text="\(name)\(location)"
        }else{
            let dataDict = self.ReboundDataArray[indexPath.row] as! NSDictionary
            
            let dataUser = dataDict["user"]as! NSDictionary
            
            let name = dataUser["name"]as! NSString
            
            let location = dataUser["location"]as! NSString
            
            let ImageDict = dataDict["images"]as! NSDictionary
            
            let ImageUrlString = ImageDict["teaser"]as! NSString
            
            DispatchQueue.global().async(execute: { () -> Void in
                
            let imageUrl: URL = URL.init(string: ImageUrlString as String)!
            let data = NSData (contentsOf: imageUrl)
                DispatchQueue.main.async{
            cell.dribbleImageView.image = UIImage(data:data! as Data)
                }
            })
            
            cell.picDetailsLabel.text="\(name)\(location)"
        }
        
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageUrl:URL!
        
        if tableView==self.PopularTableView {
            let dataDict = self.PopualarDataArray .object(at: indexPath.row)as! NSDictionary
            let imageDict = dataDict["images"]as! NSDictionary
            
            let imageUrlString = imageDict["hidpi"]as! NSString

            imageUrl = URL.init(string: imageUrlString as String)!
            
        }else if tableView==self.ReboundTableView{
            let dataDict = self.ReboundDataArray .object(at: indexPath.row)as! NSDictionary
            let imageDict = dataDict["images"]as! NSDictionary
            
            let imageUrlString = imageDict["hidpi"]as! NSString
            
            imageUrl = URL.init(string: imageUrlString as String)!
        }else{
            let dataDict = self.TimeDataArray .object(at: indexPath.row)as! NSDictionary
            let imageDict = dataDict["images"]as! NSDictionary
            
            let imageUrlString = imageDict["hidpi"]as! NSString
            
            imageUrl = URL.init(string: imageUrlString as String)!
        }
        // Register Nib
        let photoView = PhotoViewController(nibName: "PhotoViewController", bundle: nil)
        photoView.imageUrl=imageUrl
        
        self.navigationController?.navigationBar.isHidden=false
        //calling navigaton controller
        // setting naviagtion title
        self.navigationController?.navigationBar.topItem?.title="Home View"
        
        self.navigationController?.pushViewController(photoView, animated: true)
        
    }
}
