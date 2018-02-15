//
//  MultiColouredSlider.swift
//  RandomImplementations
//
//  Created by Ferit Bölezek on 2018-02-15.
//  Copyright © 2018 Ferit Bölezek. All rights reserved.
//

import Foundation
import UIKit

class MultiColouredSlider : UISlider {
    
    private enum ColoredSliderErrors : Error {
        case colorAmountTooLarge(descriptor : String)
        case colorAmountIsInvalid(descriptor : String)
    }
    
    static let purple = UIColor(red: 155 / 255, green: 89 / 255, blue: 182 / 255, alpha: 1.0)
    static let blue = UIColor(red: 52 / 255, green: 152 / 255, blue: 219 / 255, alpha: 1.0)
    static let red = UIColor(red: 231 / 255, green: 76 / 255, blue: 60 / 255, alpha: 1.0)
    static let dark = UIColor(red: 52 / 255, green: 73 / 255, blue: 94 / 255, alpha: 1.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initColors()
    }
    
    func initColors() {
        do {
            try setupView(colors: [MultiColouredSlider.purple,
                                   MultiColouredSlider.blue,
                                   MultiColouredSlider.red,
                                   MultiColouredSlider.dark])
        } catch is ColoredSliderErrors {
            print("Error occured. Please send in minimum 1 color or max 10 colors")
            
        } catch let unKnownError {
            print("Unknown error occured: \(unKnownError)")
        }
    }
    
    func setupView(colors: [UIColor]) throws {
        if (colors.count > 10) {
            throw ColoredSliderErrors.colorAmountTooLarge(descriptor: "Picking more than 10 colors is not allowed as the colors will start to squish together.")
        } else if (colors.count < 1) {
            throw ColoredSliderErrors.colorAmountIsInvalid(descriptor: "Please enter the amount of colors you wish to use.")
        }
        var indexer = 0;
        
        let rect = self.trackRect(forBounds: self.bounds)
        let dividedRectWidth = rect.width / CGFloat(colors.count)
        
        for _ in colors {
            let colorView = UIView(frame: CGRect(x: dividedRectWidth * CGFloat(indexer) + 2, y: rect.midY, width: dividedRectWidth, height: 4))
            indexer += 1;
            print(colorView.bounds)
            colorView.backgroundColor = colors[indexer - 1];
            self.addSubview(colorView)
        }
    }
    
}

