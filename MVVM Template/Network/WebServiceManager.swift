//
//  WebServiceManager.swift
//  Ashallak
//
//  Created by Seifallah Selmi on 18/06/2020.
//  Copyright © 2020 Seifallah Selmi. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class WebServiceManager {
    
    static var instance: WebServiceManager!
    
    // SHARED INSTANCE
    class func sharedInstance() -> WebServiceManager {
        self.instance = (self.instance ?? WebServiceManager())
        return self.instance
    }
    
    // METHODS
    init() {
        print(#function)
    }
    
    //MARK: Login Web Service
    
    func fetchMovies (params: [NSString: Any]?, completionHandler: @escaping Handler)   {
        //HUD.show(.progress)
        
        Alamofire.request(Domain.baseUrl() + APIEndpoint.movies, method: .get, parameters: params as Parameters?, encoding:  JSONEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result {
                    
                case .success(let responseObject):
                    print(responseObject)
                    
                    do{
                        let _ = try JSONDecoder().decode(MovieResponseModel.self, from: response.data!)
                        completionHandler(.success(response.data!))
                    }catch{
                        completionHandler(.failure(true))
                        print(error)
                    }
                    
                    
                case .failure(let error):
                    //HUD.hide()
                    SweetAlert().showAlert("Error_Title", subTitle:"Server_Down_Msg", style: AlertStyle.error)
                    print(error)
                    completionHandler(.failure(true))
                    
                }
        }
    }
    
    
}
