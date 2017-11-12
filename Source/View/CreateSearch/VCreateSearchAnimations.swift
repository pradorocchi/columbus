import UIKit

extension VCreateSearch
{
    //MARK: private
    
    private func animate(listTop:CGFloat)
    {
        viewBase.layoutTop.constant = listTop
        
        UIView.animate(withDuration:kAnimationDuration)
        { [weak self] in
            
            self?.layoutIfNeeded()
        }
    }
    
    //MARK: internal
    
    func animateShow()
    {
        animate(listTop:0)
    }
    
    func animateHide()
    {
        animate(listTop:-viewBase.kHeight)
    }
}
