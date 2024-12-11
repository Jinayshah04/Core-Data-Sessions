//
//  ViewController.swift
//  coreData-session
//
//  Created by mobile1 on 18/11/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        writeToCD()
        readToCoreData()
        // Do any additional setup after loading the view.
    }

    func addToCoreData(jokeObject:JokeModel){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        guard let jokeEntity = NSEntityDescription.entity(forEntityName: "Jokes", in: managedContext) else { return }
        
        let joke = NSManagedObject(entity: jokeEntity, insertInto: managedContext)
        
        joke.setValue(jokeObject.id, forKey: "id")
        joke.setValue(jokeObject.type, forKey: "type")
        joke.setValue(jokeObject.setup, forKey: "setup")
        joke.setValue(jokeObject.punchline, forKey: "punchline")
        
        do{
            try managedContext.save()
            print("Saved to Core Data")
        }catch let err as NSError{
            print("Failed to add to Core Data-\(err)")
        }	
    }
    
    func writeToCD(){
        let jokes=JokeModel(id: 401, type: "general", setup: "What do elves post on Social Media?", punchline: "Elf-ies")
        addToCoreData(jokeObject: jokes)
    }
    
    func readToCoreData(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do{
            let res = try managedContext.fetch(fetchData)
            print("Fetch Data")
            for data in res as! [NSManagedObject]{
                print("id-",data.value(forKey: "id") as! Int)
                print("type-",data.value(forKey: "type") as! String)
                print("setup-",data.value(forKey: "setup") as! String)
                print("punchline-",data.value(forKey: "punchline") as! String)
            }
        }
        catch let err as NSError{
            print("Failed to Fetch Data \(err)")
        }
    }
    
    func deleteCoreData(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Jokes")
        
        do{
            let res = try managedContext.fetch(fetchData)
            print("Fetch Data")
            for data in res as! [NSManagedObject]{
                managedContext.delete(data)
            }
            try managedContext.save()
        }catch let err as NSError{
            print("Failed to Fetch Data \(err)")
        }
        
    }
}

