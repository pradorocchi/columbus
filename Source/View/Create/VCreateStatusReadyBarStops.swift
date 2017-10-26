import UIKit

final class VCreateStatusReadyBarStops:
    VCollection<
    ArchCreate,
    VCreateStatusReadyBarStopsCell>
{
    weak var viewTravel:VCreateStatusReadyBarTravel!
    let kInsetsTop:CGFloat = 10
    private var cellSize:CGSize?
    private let footerSize:CGSize
    private let kFooterHeight:CGFloat = 50
    private let kCellHeight:CGFloat = 50
    
    var model:[DPlanStop]?
    {
        get
        {
            return controller.model.plan?.plan.stops?.array as? [
                DPlanStop]
        }
    }
    
    var travel:[DPlanTravel]?
    {
        get
        {
            return controller.model.plan?.plan.travels?.array as? [
                DPlanTravel]
        }
    }
    
    required init(controller:CCreate)
    {
        footerSize = CGSize(
            width:0,
            height:kFooterHeight)
        
        super.init(controller:controller)
        config()
    }
    
    required init?(coder:NSCoder)
    {
        return nil
    }
    
    override func scrollViewDidScroll(
        _ scrollView:UIScrollView)
    {
        viewTravel.collectionView.contentOffset = scrollView.contentOffset
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        referenceSizeForFooterInSection section:Int) -> CGSize
    {
        guard
        
            let count:Int = model?.count,
            count > 0
        
        else
        {
            return CGSize.zero
        }
        
        return footerSize
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        layout collectionViewLayout:UICollectionViewLayout,
        sizeForItemAt indexPath:IndexPath) -> CGSize
    {
        guard
        
            let cellSize:CGSize = self.cellSize
        
        else
        {
            let width:CGFloat = collectionView.bounds.width
            let cellSize:CGSize = CGSize(
                width:width,
                height:kCellHeight)
            self.cellSize = cellSize
            
            return cellSize
        }
        
        return cellSize
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        numberOfItemsInSection section:Int) -> Int
    {
        guard
        
            let count:Int = self.model?.count
        
        else
        {
            return 0
        }
        
        viewTravel.collectionView.reloadData()
        
        return count
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        viewForSupplementaryElementOfKind kind:String,
        at indexPath:IndexPath) -> UICollectionReusableView
    {
        let reusable:VCreateStatusReadyBarStopsFooter = reusableAtIndex(
            kind:kind,
            indexPath:indexPath)
        reusable.config(model:travel!)
        
        return reusable
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        cellForItemAt indexPath:IndexPath) -> UICollectionViewCell
    {
        let item:DPlanStop = modelAtIndex(
            index:indexPath)
        let cell:VCreateStatusReadyBarStopsCell = cellAtIndex(
            indexPath:indexPath)
        
        cell.config(
            controller:controller,
            model:item)
        
        return cell
    }
    
    override func collectionView(
        _ collectionView:UICollectionView,
        didSelectItemAt indexPath:IndexPath)
    {
        selectedCell(indexPath:indexPath)
    }
}
