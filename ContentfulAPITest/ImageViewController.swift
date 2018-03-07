//
//  ImageViewController.swift
//  ContentfulAPITest
//
//  Created by Yeontae Kim on 3/7/18.
//  Copyright © 2018 YTK. All rights reserved.
//

import UIKit
import Contentful
import Interstellar


enum PlantsResult {
    case success([Plant])
    case failure(Error)
}

let SPACE_ID = "whpdepxpcivz"
let ACCESS_TOKEN = "8526f63558bb91e2943478125ec315f19a8a3d9ff01aa315749be1d67f4b64f1"

class ImageViewController: UIViewController {
    
    private let contentful = Contentful(client: Client(spaceId: SPACE_ID, accessToken: ACCESS_TOKEN))
    var plantArray = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromContentful(completion: { (plantResult) in
            
            switch plantResult {
                
            case let .success(plants):
                
                self.plantArray = plants
                
                if self.plantArray.count > 0 {
                    performUIUpdatesOnMain() {
                        print("Fetched Plants: ", self.plantArray)
                    }
                }
                
            case let .failure(error):
                print("Fetching Error:", error)
                self.plantArray = []
            }
        })
        
    }
    
    // MARK: - Helper methods to create core data from contentful
    
    func getDataFromContentful(completion: @escaping (PlantsResult) -> Void) {
        
        var fetchedPlants = [Plant]()
        
        contentful.client.fetchEntries() {(result: Result<ArrayResponse<Entry>>) in
            
            switch result {
                
            case .success(let entries):
                
                print("entries successfully fetched")
                
                entries.items.forEach { entry in
                    
                    let jsonDictionary = entry.fields as [String: AnyObject]

                    let plant = Plant(dictionary: jsonDictionary)
                    
                    fetchedPlants.append(plant)
                    print("fetched plants: ", fetchedPlants)
                }
                
                performUIUpdatesOnMain() {
                    completion(.success(fetchedPlants))
                }
                
            case .error(let error):
                print("Uh oh, something went wrong. You can do what you want with this \(error)")
                completion(.failure(error))
            }
        }
    }

}

// Helper function
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}

