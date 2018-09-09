//
//  ActivityIndicatorView.swift
//  OnTheMap
//
//  Created by Rajeev Ranganathan on 02/09/18.
//  Copyright © 2018 Rajeev Ranganathan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class func displayLoadingIndicator (view:UIView) -> UIView{
        let loadingView = UIView.init(frame:view.bounds)
        loadingView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let loader = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        loader.startAnimating()
        loader.center = loadingView.center
        performUIUpdatesOnMain {
            loadingView.addSubview(loader)
            view.addSubview(loadingView)
        }
        return loadingView
    }
    
    class func removeLoader(view :UIView) {
        performUIUpdatesOnMain {
            view.removeFromSuperview()
        }
    }
}
