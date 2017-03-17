//
//  Google.swift
//  testingProjectWithRXSWIFT
//
//  Created by Cyberk on 3/16/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire


final class GoogleModel {
    let key = "AIzaSyCgFAmCSFQeqjxS-HtXBZCmgpDanb0yw3U"
    let lat = "11.536612"
    let long = "104.884781"
    func createGoogleDataObservable() -> Observable<[String:Any]> {
        
        return Observable<[String:Any]>.create({ (observer) -> Disposable in
            
//            let session = URLSession.shared
//            let task = session.dataTask(with: URL(string:"https://www.google.com")!) { (data, response, error) in
//                
//                // We want to update the observer on the UI thread
//                DispatchQueue.main.async {
//                    if let err = error {
//                        // If there's an error, send an Error event and finish the sequence
//                        observer.onError(err)
//                    } else {
//                        if let googleString = String(data: data!, encoding: .ascii) {
//                            //Emit the fetched element
//                            observer.onNext(googleString)
//                        } else {
//                            //Send error string if we weren't able to parse the response data
//                            observer.onNext("Error! Unable to parse the response data from google!")
//                        }
//                        //Complete the sequence
//                        observer.onCompleted()
//                    }
//                }
//            }
//            
//            task.resume()
            
            let url = "https://maps.googleapis.com/maps/api/geocode/json?&key=\(self.key)&latlng=\(self.lat)%2C\(self.long)"
            //  Mark
            Alamofire.request(url).responseJSON { (response) in
                
                if let data = response.data {
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
                        print(jsonResult)
                        observer.onNext(jsonResult)
                        
//                        if let json = jsonResult["results"] as? [Dictionary<String, AnyObject>]{
//                            print(json)
                        
//                            if let address = json[0]["formatted_address"] as? String {
//                                print(address)
//                                
//                            }
//                            if let currentPlaceid = json[0]["place_id"] as? String{
//                                
//                            }
                            
//                        }
                        observer.onCompleted()
                        
                    } catch {
                        print("JSON Processing Failed")
                    }
                    
                }
            }

            
            //Return an AnonymousDisposable
            return Disposables.create(with: {
                //Cancel the connection if disposed
//                task.cancel()
            })
        })
    }
}


