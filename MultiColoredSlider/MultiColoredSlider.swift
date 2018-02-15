//
//  MultiColouredSlider.swift

//  Copyright 2018 Ferit Bölezek

//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

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

