//
//  BaseModel.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

protocol GenericJSONParsable {
    init(jsonDict: [String: Any])
}

protocol GenericBaseModel: GenericJSONParsable, CustomStringConvertible {
}

