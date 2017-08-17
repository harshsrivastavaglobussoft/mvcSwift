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
    
        
        //calling the model
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
    
    //calling tableView Delegates
    func forReboundTable() -> Void {
        self.ReboundTableView.delegate=self;
        self.ReboundTableView.dataSource=self;
    }
    
    func forTimeTable() ->Void {
        self.TimeTableView.delegate=self
        self.TimeTableView.dataSource=self
    }
    
    func forPopularTable() -> Void {
        self.PopularTableView.dataSource=self
        self.PopularTableView.delegate=self
    }
    
    //segment View Action
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

//table view delegates and datasource
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
            var dataModel:MainModel!
            dataModel = self.PopualarDataArray[indexPath.row] as! MainModel
            
            let name = dataModel.user.name
            
            let location = dataModel.user.location
            
            let avtarUrlString = dataModel.user.avatar_url
            let avatarUrl = URL.init(string: avtarUrlString! as String)
            
            
            let ImageUrlString = dataModel.images.normal
            let imageUrl = URL.init(string: ImageUrlString! as String)
            
            cell.profilePicImageView.layer.cornerRadius=cell.profilePicImageView.frame.size.height/2
            cell.profilePicImageView.layer.masksToBounds=true
            cell.profilePicImageView .sd_setImage(with: avatarUrl)
            
            cell.dribbleImageView.sd_setShowActivityIndicatorView(true)
            cell.dribbleImageView.sd_setIndicatorStyle(.gray)
            cell.dribbleImageView .sd_setImage(with: imageUrl)
            
            cell.picDetailsLabel.text="\(name!)\(location!)"

        }
        else if tableView==self.TimeTableView{
            var dataModel:MainModel!
            dataModel = self.TimeDataArray[indexPath.row] as! MainModel
            
            let name = dataModel.user.name
            
            let location = dataModel.user.location
            
            let avtarUrlString = dataModel.user.avatar_url
            let avatarUrl = URL.init(string: avtarUrlString! as String)
            
            
            let ImageUrlString = dataModel.images.normal
            let imageUrl = URL.init(string: ImageUrlString! as String)
            
            cell.profilePicImageView.layer.cornerRadius=cell.profilePicImageView.frame.size.height/2
            cell.profilePicImageView.layer.masksToBounds=true
            cell.profilePicImageView .sd_setImage(with: avatarUrl)
            
            cell.dribbleImageView.sd_setShowActivityIndicatorView(true)
            cell.dribbleImageView.sd_setIndicatorStyle(.gray)
            cell.dribbleImageView .sd_setImage(with: imageUrl)
            
            cell.picDetailsLabel.text="\(name!)\(location!)"
        }else{
            var dataModel:MainModel!
            dataModel = self.ReboundDataArray[indexPath.row] as! MainModel
            
            let name = dataModel.user.name
            
            let location = dataModel.user.location
            
            let avtarUrlString = dataModel.user.avatar_url
            let avatarUrl = URL.init(string: avtarUrlString! as String)
            
            
            let ImageUrlString = dataModel.images.normal
            let imageUrl = URL.init(string: ImageUrlString! as String)
            
            cell.profilePicImageView.layer.cornerRadius=cell.profilePicImageView.frame.size.height/2
            cell.profilePicImageView.layer.masksToBounds=true
            cell.profilePicImageView .sd_setImage(with: avatarUrl)
            
            cell.dribbleImageView.sd_setShowActivityIndicatorView(true)
            cell.dribbleImageView.sd_setIndicatorStyle(.gray)
            cell.dribbleImageView .sd_setImage(with: imageUrl)
            
            cell.picDetailsLabel.text="\(name!)\(location!)"
        }
        
        
      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let imageUrl:URL!
        
        if tableView==self.PopularTableView {
            let selectedData = self.PopualarDataArray .object(at: indexPath.row)as! MainModel
            
            let imageUrlString:NSString = selectedData.images.hidpi!
            
            imageUrl = URL.init(string: imageUrlString as String)!
            
        }else if tableView==self.ReboundTableView{
            let selectedData = self.ReboundDataArray .object(at: indexPath.row)as! MainModel
            
            let imageUrlString = selectedData.images.hidpi!
            
            imageUrl = URL.init(string: imageUrlString as String)!
        }else{
            let selectedData = self.TimeDataArray .object(at: indexPath.row)as! MainModel
            
            let imageUrlString = selectedData.images.hidpi!
            
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
