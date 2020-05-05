//
//  RowModel.swift
//  TelstraDemoApp
//
//  Created by RajeshDeshmukh on 30/04/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

struct DisplayRowModel: Decodable {
  
  let title:String?
  let description:String?
  let imageHref:String?
  
}

struct AboutCandaModel: Decodable {
  
  let title: String?
  let rows: [DisplayRowModel]
  
}
