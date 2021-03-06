import Foundation
import CoreLocation

extension MCreatePlan
{
    //MARK: private
    
    private func loadProgress()
    {
        guard
        
            let view:VCreateStatusReady = model?.view?.view as? VCreateStatusReady
        
        else
        {
            return
        }
        
        view.viewBar.viewLoader.loadProgress()
    }
    
    private func asyncAddStop(coordinate:CLLocationCoordinate2D)
    {
        guard
            
            let database:Database = model?.database,
            let settings:DSettings = model?.settings
            
        else
        {
            return
        }
        
        let location:CLLocation = CLLocation(
            latitude:coordinate.latitude,
            longitude:coordinate.longitude)
        
        geocodeLocation(location:location)
        { [weak self] (name:String?) in
            
            guard
                
                let name:String = name
                
            else
            {
                return
            }
            
            self?.addStop(
                database:database,
                settings:settings,
                name:name,
                coordinate:coordinate)
        }
    }
    
    private func addStop(
        database:Database,
        settings:DSettings,
        name:String,
        coordinate:CLLocationCoordinate2D)
    {
        database.create
        { [weak self] (stop:DPlanStop) in
            
            self?.addStop(
                database:database,
                settings:settings,
                stop:stop,
                name:name,
                coordinate:coordinate)
        }
    }
    
    private func addStop(
        database:Database,
        settings:DSettings,
        stop:DPlanStop,
        name:String,
        coordinate:CLLocationCoordinate2D)
    {
        stop.name = name
        stop.coordinate = coordinate
        
        plan.connect(
            database:database,
            settings:settings,
            stop:stop)
        { [weak self] in
            
            self?.configTravel(stop:stop)
        }
    }
    
    private func configTravel(stop:DPlanStop)
    {
        guard
        
            let travel:DPlanTravel = stop.destinationTravel
        
        else
        {
            stopAdded(stop:stop)
            
            return
        }
        
        factoryDirections(travel:travel)
        { [weak self] in
            
            self?.stopAdded(stop:stop)
        }
    }
    
    private func stopAdded(stop:DPlanStop)
    {
        DispatchQueue.main.async
        { [weak self] in
            
            self?.asyncStopAdded(stop:stop)
        }
    }
    
    private func asyncStopAdded(stop:DPlanStop)
    {
        addAnnotation(stop:stop)
        updateStops()
        selectLastStop()
    }
    
    //MARK: internal
    
    func addStop(coordinate:CLLocationCoordinate2D)
    {
        loadProgress()
        
        DispatchQueue.global(qos:DispatchQoS.QoSClass.background).async
        { [weak self] in
            
            self?.asyncAddStop(coordinate:coordinate)
        }
    }
}
