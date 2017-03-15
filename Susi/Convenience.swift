//
//  Convenience.swift
//  MeetingApp
//
//  Created by Chashmeet Singh on 31/01/17.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import Foundation

extension Client {

    // MARK: - Auth Methods

    func loginUser(_ params: [String : AnyObject], _ completion: @escaping(_ success: Bool, _ error: String) -> Void) {

        _ = taskForPOSTMethod(false, Methods.Login, parameters: params, completionHandlerForPOST: { (results, message) in
            
            if let error = message {
                print(error.localizedDescription)
                completion(false, ResponseMessages.ServerError)
                return
            } else {
                
                guard let successMessage = results?[UserKeys.Message] as? String else {
                    completion(false, ResponseMessages.InvalidParams)
                    return
                }
                
                completion(true, successMessage)
                return
            }
            
        })

    }

    func registerUser(_ params: [String : AnyObject], _ completion: @escaping(_ success: Bool, _ error: String) -> Void) {

        _ = taskForPOSTMethod(false, Methods.Register, parameters: params, completionHandlerForPOST: { (results, message) in

            if let error = message {
                print(error.localizedDescription)
                completion(false, ResponseMessages.ServerError)
                return
            } else {
                
                guard let successMessage = results?[UserKeys.Message] as? String else {
                    completion(false, ResponseMessages.InvalidParams)
                    return
                }
                
                completion(true, successMessage)
                
            }

        })

    }

    func logoutUser(_ completion: @escaping(_ success: Bool, _ error: String) -> Void) {

        

    }
    
    // MARK: - Chat Methods
    
    func queryResponse(_ params: [String : String], _ completion: @escaping(_ response: Message?, _ success: Bool, _ error: String) -> Void) {
     
        _ = taskForGETMethod(Methods.Chat, parameters: params, completionHandlerForGET: { (results, message) in
            
            if let error = message {
                print(error.localizedDescription)
                completion(nil, false, ResponseMessages.InvalidParams)
                return
            } else {
                
                guard let response = results as? [String : AnyObject] else {
                    completion(nil, false, ResponseMessages.InvalidParams)
                    return
                }
                
                let message = Message.getMessageFromResponse(response, isBot: true)
                
                completion(message, true, "cool")
                return
                
            }
            
        })
        
    }

}