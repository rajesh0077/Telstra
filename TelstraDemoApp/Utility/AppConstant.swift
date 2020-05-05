//
//  AppConstant.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//
import UIKit
class AppConstant {
  
  ///  List of ApiURLS
  struct ApiURLS {
    static let aboutCanada = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
  }
  
  ///  List of literal Strings
  struct LiteralString {
    static let errorTitle = "Error"
    static let errorMsg = "Failed to load data from server."
    static let okBtn = "OK"
  }
  
  ///  List of  color codes
  struct AppColor {
    static let kColor_black = UIColor.black
    static let kColor_DarkGray = UIColor.darkGray
  }
  
  ///  List of fonts
  struct AppFonts {
    static let kboldSystemFont16 = UIFont.boldSystemFont(ofSize: 16)
    static let ksystemFont14 = UIFont.systemFont(ofSize: 14)
  }
  
  ///  List of cell identifires
  struct CellIdentifire {
    static let ImageTableViewCellId = "ImageTableViewCell"
  }
  
  ///  List of Images
  struct AppImage {
    static let placeholder = "placeholder"
  }
  
}
