//
//  LandingVC.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit

class LandingVC: UITableViewController {
  
  /// private constants
  private struct Constant {
    static let estimatedRowHeight: CGFloat = 44
  }
  
  var noDataFound: Bool?
  
  /// Variables
  lazy var viewModelObj = {
    return AboutCandaViewModel()
  }()
  
  // MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initialTableViewSetup()
    callAPI()
  }
  
}

/// Utility Methods of UITableView
extension LandingVC {
  
  /// Function to set initial Setup of UI
  func initialTableViewSetup() {
    DispatchQueue.main.async {
      self.registerUINibForCell()
      self.configureTableView()
      self.noDataFound = true
      self.tableView?.reloadData()
    }
  }
  
  /// Function to configure TableView
  func configureTableView() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    tableView?.refreshControl = refreshControl
    
    tableView?.dataSource = self
    tableView?.rowHeight = UITableView.automaticDimension
    tableView?.estimatedRowHeight = LandingVC.Constant.estimatedRowHeight
    tableView?.translatesAutoresizingMaskIntoConstraints = false
    tableView?.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
    tableView?.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
    tableView?.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
    tableView?.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
  }
  
  /// Function to add Pull to Refresh functionality
  /// - parameter instance of refreshControl
  @objc func pullToRefresh(refreshControl: UIRefreshControl) {
    DispatchQueue.main.async {
      self.viewModelObj.displayAboutCanda?.removeAll()
      self.noDataFound = true
      self.tableView?.reloadData()
      self.refreshControl?.endRefreshing()
    }
    callAPI()
  }
  
  /// Function to  register tableViewCell
  func registerUINibForCell() {
    if let tableView = tableView {
      tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: AppConstant.CellIdentifire.ImageTableViewCellId)
    }
  }
  
  /// Function to creation cell  and it's configuration
  /// - parameter indexPath: IndexPath for cell
  /// - ReturnS: instance of ImageTableViewCell
  func getImageTableViewCellFor(indexPath: IndexPath) -> ImageTableViewCell? {
    let cell = tableView?.dequeueReusableCell(withIdentifier: AppConstant.CellIdentifire.ImageTableViewCellId, for: indexPath) as! ImageTableViewCell
    cell.setUpWith(noDataFound: noDataFound ?? false)
    self.tableView.separatorStyle = noDataFound ?? false ? .none: .singleLine
    if noDataFound ?? false {
      return cell
    }
    cell.rowCellModel = viewModelObj.displayAboutCanda?[indexPath.row]
    return cell
  }
  
}


/// Utility Methods of  API
extension LandingVC {
  
  /// Function to fetch API Data
  @objc func callAPI() {
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
        if self.viewModelObj.displayAboutCanda?.count ?? 0 > 0 {
          self.noDataFound = false
          self.tableView.reloadData()
        }
      }
    } else { // show error dialog
      DispatchQueue.main.async {
        self.noDataFound = true
        self.tableView.reloadData()
        self.showAlert(title: AppConstant.LiteralString.errorTitle,
                       message : exception?.localizedDescription ?? AppConstant.LiteralString.errorMsg,
                       actionTitle : AppConstant.LiteralString.okBtn)
      }
      
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

// MARK: - Table view data source

extension LandingVC {
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.noDataFound ?? false {
      return 1
    }
    return viewModelObj.displayAboutCanda?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return getImageTableViewCellFor(indexPath: indexPath) ?? UITableViewCell()
  }
  
}
