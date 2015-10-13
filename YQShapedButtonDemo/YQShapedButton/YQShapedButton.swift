//
//  YQShapedButton.swift
//  YQShapedButtonDemo
//
//  Created by Yaqing Wang on 10/13/15.
//  Copyright © 2015 thoughtworks.com. All rights reserved.
//

import UIKit

class YQShapedButton: UIButton {

    var previousTouchPoint = CGPointZero
    var previousTouchHitTestResponse = false
    var image : UIImage? = nil
    var backgroundImage : UIImage? = nil

    override func setImage(image: UIImage?, forState state: UIControlState) {
        super.setImage(image, forState: state)
        self.setup()
    }
    
    override func setBackgroundImage(image: UIImage?, forState state: UIControlState) {
        super.setBackgroundImage(image, forState: state)
        self.setup()
    }
    
    override var enabled : Bool{
        didSet{
            self.setup()
        }
    }
    
    override var highlighted : Bool{
        didSet{
            self.setup()
        }
    }
    
    override func awakeFromNib() {
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    func isAlphaVisibleAtPoint(var point: CGPoint, image: UIImage) -> Bool{
        let imageViewRect = self.imageRectForContentRect(self.bounds)
        point.x -= imageViewRect.origin.x
        point.y -= imageViewRect.origin.y

        let imageSize = image.size
        let boundSize = imageViewRect.size
        point.x *= CGFloat(imageSize.width / boundSize.width)
        point.y *= CGFloat(imageSize.height / boundSize.height)
        let color = image.colorAtPixel(point)
        var alpha : CGFloat = 0.0
        color.getRed(nil, green: nil, blue: nil, alpha: &alpha)
        return alpha >= 0.1
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        if super.pointInside(point, withEvent: event){
            
            if (CGPointEqualToPoint(point, self.previousTouchPoint)) {
                return self.previousTouchHitTestResponse;
            } else {
                self.previousTouchPoint = point;
            }
            var response = false
    
            switch (self.image != nil, self.backgroundImage != nil){
                
                case (false, false):
                    response = true
                case (true, false):
                    response = self.isAlphaVisibleAtPoint(point, image: self.image!)
                case (false, true):
                    response = self.isAlphaVisibleAtPoint(point, image: self.backgroundImage!)
                default:
                    if self.isAlphaVisibleAtPoint(point, image: self.image!){
                        response = true
                    }else{
                        response = self.isAlphaVisibleAtPoint(point, image: self.backgroundImage!)
                    }
            }
            
            self.previousTouchHitTestResponse = response;
            return response;
        }else{
            return false
        }
    }
    
    func setup(){
        self.updateImageCacheForCurrentState()
        self.resetHintTestCache()
    }
    
    func updateImageCacheForCurrentState(){
        self.image = self.currentImage
        self.backgroundImage = self.currentBackgroundImage
    }
    
    func resetHintTestCache(){
        self.previousTouchHitTestResponse = false
        self.previousTouchPoint = CGPointZero
    }
}
