import Foundation
import CoreLocation

extension MCreatePlan
{
    //MARK: private
    
    private func addStop(
        name:String,
        coordinate:CLLocationCoordinate2D)
    {
        database.create
        { [weak self] (stop:DPlanStop) in
            
            self?.addStop(
                stop:stop,
                name:name,
                coordinate:coordinate)
        }
    }
    
    private func addStop(
        stop:DPlanStop,
        name:String,
        coordinate:CLLocationCoordinate2D)
    {
        stop.name = name
        stop.coordinate = coordinate
        
        plan.connect(
            database:database,
            stop:stop)
        { [weak self] in
        
            self?.stopAdded(stop:stop)
        }
    }
    
    private func stopAdded(stop:DPlanStop)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.addAnnotation(stop:stop)
            self?.selectLastStop()
        }
    }
    
    private func addAnnotation(stop:DPlanStop)
    {
        guard
        
            let view:VCreateStatusReady = model?.view?.view as? VCreateStatusReady
        
        else
        {
            return
        }
        
        view.viewMap.addAnnotation(stop)
        view.viewMap.centreAndSelect(
            stop:stop)
    }
    
    private func selectLastStop()
    {
        guard
            
            let view:VCreateStatusReady = model?.view?.view as? VCreateStatusReady,
            let totalStops:Int = plan.stops?.count
            
        else
        {
            return
        }
        
        let lastStop:Int = totalStops - 1
        
        view.viewBar.reload()
        view.viewBar.viewStops.selectItem(
            index:lastStop)
    }
    
    //MARK: internal
    
    func addStop(coordinate:CLLocationCoordinate2D)
    {
        let location:CLLocation = CLLocation(
            latitude:coordinate.latitude,
            longitude:coordinate.longitude)
        
        geocodeLocation(location:location)
        { [weak self] (name:String?) in
            
            print("location name: \(name)")
            
            guard
                
                let name:String = name
            
            else
            {
                return
            }
            
            self?.addStop(
                name:name,
                coordinate:coordinate)
        }
    }
}
