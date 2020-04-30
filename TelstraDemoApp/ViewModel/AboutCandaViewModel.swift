//
//  AboutCandaViewModel.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation
class AboutCandadaViewModel {
  weak var myLandingVCObj: LandingVC?
  var displayCellViewModelObj: DisplayCellViewModel?
  var navTitle: String?
  
  ///  function to fetch API Data by given URL
  func fetchAPIData(){
    let urlStr = AppConstant.ApiURLS.aboutCanada
    APIHandler.shared.getImagesWith(urlStr: urlStr, onCompletion: {(data, error) in
      DispatchQueue.main.async {
        guard let data = data else {
          self.navTitle = ""
          self.myLandingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
          return
        }
        let jsonStr = String(decoding: data, as: UTF8.self)
        if  let jsonDictionaryData = jsonStr.parseJSONString as? [String: Any] {
          self.navTitle = jsonDictionaryData["title"] as? String ?? ""
          self.displayCellViewModelObj  = self.getDisplayCellViewModel(responceDict: jsonDictionaryData)
          self.myLandingVCObj?.didReceiveApiResponse(isSuccess: true, exception: error as AnyObject?)
        }
      }
    })
  }
  
  ///  function to get viewmodel
  /// - parameter [String: Any]: instance of responce Dictionary
  /// - Returns: instance of viewModel object
  func getDisplayCellViewModel(responceDict: [String: Any]) -> DisplayCellViewModel {
    return DisplayCellViewModel(responceDict: responceDict)
  }
  
  ///  function to get viewmodel from local json file for XCTest
  func readlocalJson() {
    if let path = Bundle.main.path(forResource: "localJSON", ofType: "json") {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
          // do stuff
          self.navTitle = jsonResult["title"] as? String ?? ""
          self.displayCellViewModelObj = self.getDisplayCellViewModel(responceDict: jsonResult)
        }
      } catch {
        print("parse error: \(error.localizedDescription)")
      }
    }
    else {
      print("Invalid filename/path.")
    }
  }
  
}

///  This view-model help to display row of tableview
struct DisplayCellViewModel {
  var arrayAboutCanda: [RowModel]
  init(responceDict: [String: Any]) {
    arrayAboutCanda = [RowModel]()
    if let rowsObj = responceDict["rows"] {
      for obj in rowsObj as! [[String: AnyObject]] {
        self.arrayAboutCanda.append(RowModel(dictionary: obj))
      }
    }
  }
}
