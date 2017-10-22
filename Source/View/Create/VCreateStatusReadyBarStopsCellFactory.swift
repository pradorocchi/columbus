import UIKit

extension VCreateStatusReadyBarStopsCell
{
    //MARK: internal
    
    func factoryViews()
    {
        let buttonRemove:UIButton = UIButton()
        buttonRemove.translatesAutoresizingMaskIntoConstraints = false
        buttonRemove.setImage(
            #imageLiteral(resourceName: "assetGenericRemove").withRenderingMode(UIImageRenderingMode.alwaysOriginal),
            for:UIControlState.normal)
        buttonRemove.setImage(
            #imageLiteral(resourceName: "assetGenericRemove").withRenderingMode(UIImageRenderingMode.alwaysTemplate),
            for:UIControlState.highlighted)
        buttonRemove.imageView!.clipsToBounds = true
        buttonRemove.imageView!.contentMode = UIViewContentMode.center
        buttonRemove.imageView!.tintColor = UIColor.black
        buttonRemove.addTarget(
            self,
            action:#selector(selectorRemove(sender:)),
            for:UIControlEvents.touchUpInside)
        
        let viewField:VCreateStatusReadyBarStopsCellField = VCreateStatusReadyBarStopsCellField()
        self.viewField = viewField
        
        addSubview(buttonRemove)
        addSubview(viewField)
        
        NSLayoutConstraint.equalsVertical(
            view:buttonRemove,
            toView:self)
        NSLayoutConstraint.rightToRight(
            view:buttonRemove,
            toView:self)
        NSLayoutConstraint.width(
            view:buttonRemove,
            constant:kRemoveWidth)
        
        NSLayoutConstraint.equalsVertical(
            view:viewField,
            toView:self,
            margin:kFieldMarginVertical)
        NSLayoutConstraint.leftToLeft(
            view:viewField,
            toView:self,
            constant:kFieldLeft)
        NSLayoutConstraint.rightToLeft(
            view:viewField,
            toView:buttonRemove)
    }
}
