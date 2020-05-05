//
//  AboutCandaViewModel.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import Foundation
class AboutCandaViewModel {
  
  weak var myLandingVCObj: LandingVC?
  var displayAboutCanda: [DisplayRowModel]?
  var navTitle: String?
  
  ///  function to fetch API Data by given URL
  func fetchAPIData(){
    let urlStr = AppConstant.ApiURLS.aboutCanada
    APIHandler.shared.callAPI(withURLStr: urlStr, onCompletion: {(data, error) in
      DispatchQueue.main.async {
        
        guard let data = data else {
          self.navTitle = ""
          self.myLandingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
          return
        }
        
        let jsonStr = String(decoding: data, as: UTF8.self)
        do {
          
          let results = try JSONDecoder().decode(AboutCandaModel.self, from: jsonStr.data(using: .utf8)!)
          self.navTitle = results.title
          self.displayAboutCanda  = results.rows
          
          self.myLandingVCObj?.didReceiveApiResponse(isSuccess: true, exception: error as AnyObject?)
          
        } catch {
          print(error.localizedDescription)
          self.myLandingVCObj?.didReceiveApiResponse(isSuccess: false, exception: error as AnyObject?)
        }
        
      }
    })
  }
  
}
