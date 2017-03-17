//
//  ViewController.swift
//  testingProjectWithRXSWIFT
//
//  Created by Cyberk on 3/14/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textViews: UITextView!
    
    
    let google = GoogleModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        google.createGoogleDataObservable().subscribe(onNext: { [weak self] (element) in
            print(element)
            if let json = element["results"] as? [Dictionary<String, AnyObject>]{
                print(json)
                if let address = json[0]["formatted_address"] as? String {
                    print(address)
                    self?.textViews.text = "\(address)"
                    
                }
                
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

