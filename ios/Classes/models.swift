//
//  Models.swift
//  evergage_flutter
//
//  Created by Marcelo Jaime on 14/09/22.
//

import Foundation

class SaleLine: Decodable{
    var id: String;
    var name: String;
    var price: Double;
    var quantity: Int;
    
    init(id: String, name: String, price: Double, quantity: Int){
        self.id = id;
        self.name = name;
        self.price = price;
        self.quantity = quantity;
    }
}

class ListSaleLine: Decodable{
    var list: [SaleLine]
    
    init(list: [SaleLine]){
        self.list = list;
    }
}
