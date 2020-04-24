//
//  ViewController.swift
//  CallKitIconBlink
//
//  Created by Kenji Tayama on 2020/04/24.
//  Copyright © 2020 Example. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController, CXProviderDelegate {
    
    private let callController = CXCallController(queue: .main)
    private let provider: CXProvider
    
    private let callingUUID = UUID()
    
    required init?(coder: NSCoder) {

        let providerConfiguration = CXProviderConfiguration(localizedName: "Example")

        // icons from https://github.com/Lax/Learn-iOS-Swift-by-Examples/tree/master/Speakerbox/Speakerbox/Assets.xcassets/IconMask.imageset
        if let imageData = UIImage(named: "callkit-icon")?.pngData() {
            providerConfiguration.iconTemplateImageData = imageData 
        }
        
        self.provider = CXProvider(configuration: providerConfiguration)
        
        super.init(coder: coder)
        
        provider.setDelegate(self, queue: DispatchQueue.main)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let handle = CXHandle(type: .generic, value: "John Appleseed")
        let startCallAction = CXStartCallAction(call: callingUUID, handle: handle)
        let transaction = CXTransaction(action: startCallAction)
        
        self.callController.request(transaction) { error in
            
            if let error = error {
                print("CXStartCallAction error: \(error.localizedDescription)")
            }
        }
    }

    
    // MARK: - CXProviderDelegate
    
    func providerDidReset(_ provider: CXProvider) {
        
    }
    
    func provider(_ provider: CXProvider, perform action: CXSetMutedCallAction) {
        action.fulfill()
    }    
}

