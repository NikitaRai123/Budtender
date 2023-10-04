//
//  ShowBanner.swift
//  SixFigureDays
//
//  Created by apple on 04/08/22.
//

import Foundation
import BRYXBanner

class ShowBanner{
    static func show(title:String?){
        let banner = Banner(title: "", subtitle: title, image: UIImage(named: ""), backgroundColor: .red)
        banner.dismissesOnTap = true
        banner.textColor = .black
        banner.backgroundColor = .red
        banner.show(duration: 1.0)
    }
}
