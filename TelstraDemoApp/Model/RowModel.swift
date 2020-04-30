//
//  RowModel.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

struct RowModel {
  let title:String?
  let description:String?
  let imageHref:String?
  
  init(){
    self.title = ""
    self.description = ""
    self.imageHref = ""
  }
  
  init(dictionary: [String: AnyObject]) {
    self.title = dictionary["title"] as? String
    self.description = dictionary["description"] as? String
    self.imageHref = dictionary["imageHref"] as? String
  }
}
