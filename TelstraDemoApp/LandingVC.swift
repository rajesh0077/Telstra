//
//  LandingVC.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class LandingVC: UITableViewController {
    /// Variables
    lazy var viewModelObj = {
        return AboutCandadaViewModel()
    }()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAPI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    
}
/// Utility Methods of  API
extension LandingVC {
    
    /// Function to fetch API Data
    func callAPI() {
        viewModelObj.myLandingVCObj = self
        viewModelObj.fetchAPIData()
    }
    
    /// API Response Received
    /// - parameter Bool: is success from
    /// - parameter AnyObject?:  instance of view model object
    /// - parameter AnyObject: instance of exception if any
    func didReceiveApiResponse(isSuccess: Bool, exception: AnyObject?) {
        if isSuccess {
            DispatchQueue.main.async {
                self.title = self.viewModelObj.navTitle
                print( self.viewModelObj.displayCellViewModelObj)
            }
        } else { // show error dialog
            self.showAlert(title: AppConstant.LocalizeString.errorTitle,
                           message : AppConstant.LocalizeString.errorMsg ,
                           actionTitle : AppConstant.LocalizeString.okBtn)
        }
    }
}

// MARK: - Helper Methods

extension LandingVC {
    
    /// Function to displays alertview controller
    /// - parameter String: title for alert
    /// - parameter String: message for alert
    /// - parameter String: actionbtnTitle for alert
    func showAlert(title : String , message : String , actionTitle : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
