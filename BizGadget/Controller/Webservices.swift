//
//  Webservices.swift
//  BizGadget
//
//  Created by Yogesh Date on 13/08/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import Alamofire

class Webservices: NSObject {
    
    static var shared : Webservices = {
        var webservices = Webservices()
        
        return webservices
    }()
    
    let headers = [
        "Content-Type":"application/x-www-form-urlencoded"
    ]
    
    //1 Signin
    //2 SignUp Consumer
    //3 SignUp Business
    //4 category_list
    
    
    
    //1 Signin
    func Signin(username: String,
                password: String,
                success: @escaping(_ success: User)-> Void,
                failure: @escaping(_ failure: String)-> Void)  {
        
        let parametre = ["user_name": username,
                         "password": password]
        
        Alamofire.request("\(WEB_API_URL)signin",
            method: .post,
            parameters: parametre,
            encoding: URLEncoding.default,
            headers: headers).responseJSON {
                response in
                print("\n Signin Response =\(response.result.value ?? "Not yet ")")
                
                if response.result.isSuccess {
                    
                    guard let responseData = response.data else {
                        failure("Data not found")
                        return
                    }
                    do
                     {
                        let userData = try JSONDecoder().decode(UserData.self, from: responseData)
                        if userData.result ?? false {
                            success((userData.Response?.user)!)
                        } else {
                            failure(userData.message ?? "Error")
                        }
                    }
                    catch {
                        failure("User name and password not matched")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "error")
                }
        }
    }
    
    
    
    
    
    //2 SignUp Consumer
    func SignUpConsumer(user_name: String,
                        email: String,
                        password: String,
                        mobile: String,
                        type: String,
                        latitude: String,
                        longitude: String,
                        accuracy: Int,
                        tags:[String],
                        success: @escaping(_ success: String)-> Void,
                        failure: @escaping(_ failure: String)-> Void) {
        
        let parameters = ["user_name": user_name,
                         "email": email,
                         "password": password,
                         "mobile": mobile,
                         "type": type,
                         "latitude": latitude,
                         "longitude": longitude,
                         "accuracy": accuracy,
                         "tags": [tags] ] as [String : Any]
        
        Alamofire.request("\(WEB_API_URL)signup",
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers).responseJSON {
                response in
                print("Response =\(response.result.value ?? "Not yet")")
                
                if response.result.isSuccess {
                    
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "error")
                }
        }
        
    }
    
    
    func randomString(length: Int) -> String {
        let letters : NSString = WEB_DEFAULT as NSString
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    
   //3 SignUp Business
    func SignUpBusiness(user_name: String,
                        email: String,
                        password: String,
                        mobile: String,
                        type: String,
                        business_name: String,
                        business_owner_first_name:String,
                        business_owner_last_name: String,
                        business_address: String,
                        business_mobile: String,
                        latitude: String,
                        longitude: String,
                        accuracy: String,
                        tags:[String],
                        image0:UIImage,
                        success: @escaping(_ success: String)-> Void,
                        failure: @escaping(_ failure: String)-> Void) {
        
        let parameters = ["user_name": user_name,
                          "email": email,
                          "password": password,
                          "mobile": mobile,
                          "type": type,
                          "business_name": business_name,
                          "business_owner_first_name": business_owner_first_name,
                          "business_owner_last_name": business_owner_last_name,
                          "business_address": business_address,
                          "business_mobile": business_mobile,
                          "latitude": latitude,
                          "longitude": longitude,
                          "accuracy": accuracy,
                          "tags": [tags],
                          "image0": image0] as [String : Any]
        
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let name1 = self.randomString(length: 12)
            multipartFormData.append(UIImageJPEGRepresentation(image0 , 0.5)!, withName: "style_photo", fileName: "image\(name1).jpg", mimeType: "image/jpeg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold:UInt64.init(),
           to: "\(WEB_API_URL)signup",
            method: .post,
            headers: headers,
            encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    //print("the status code is :")
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("something")
                    })
                    upload.responseJSON {
                        response in
                        
                        print("Response Photo =\(String(describing: response.result.value))")
                        if response.response?.statusCode == 200 {
                            // succes response
                            
                        }
                        if response.response?.statusCode != 200 {
                            //error Message

                        }
                    }
                    break
                case .failure(let encodingError):
                    failure(encodingError.localizedDescription)
                    break
                }
        })
    }

        
        
       //4 category_list
        func categoryList(success: @escaping(_ success: [category_data])-> Void,
                          failure: @escaping(_ failure: String)->Void) {
            
            Alamofire.request("\(WEB_API_URL)category_list",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: headers).responseJSON {
                    response in
                    print("categoryList Response = \(response.result.value ?? "Not Null")")
                    if response.result.isSuccess {
                            guard let response = response.data else {
                                failure("Data not found")
                                return
                            }
                            do {
                                let responseData = try JSONDecoder().decode(CategoryResponse.self, from: response)
                                if responseData.result ?? false {
                                    if let obj = responseData.response?.category_data {
                                        success(obj)
                                    } else {
                                        failure("No Data found")
                                    }
                                }
                            } catch {
                                failure("Json error")
                        }
                    }
                    if response.result.isFailure {
                        failure(response.result.error?.localizedDescription ?? "error")
                    }
            }
        }
        
    
        
        
    
    
    /*
    func salonUploadReport(withcaseid customer_case_id:String,
                           hair_stylist_id :String,
                           date_time       :String,
                           style_photo     :UIImage,
                           success         :@escaping(_:String)->Void,
                           failure         :@escaping(_:String)->Void){
        
        let parameter :[String:Any] = [WEB_CUST_CASE_ID :customer_case_id,
                                       WEB_HAIR_ID      :hair_stylist_id,
                                       WEB_DATE_TIME    :date_time
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let name1 = self.randomString(length: 12)
            multipartFormData.append(UIImageJPEGRepresentation(style_photo , 0.5)!, withName: "style_photo", fileName: "image\(name1).jpg", mimeType: "image/jpeg")
            for (key, value) in parameter {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold:UInt64.init(),
           to: "\(WEB_API_URL)\(WEB_API_UPLOAD_REPORT)",
            method: .post,
            headers: headers,
            encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    //print("the status code is :")
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("something")
                    })
                    upload.responseJSON {
                        response in
                        
                        //print("Response Photo =\(String(describing: response.result.value))")
                        if response.response?.statusCode == 200 {
                            // succes response
                            let dictResponse : [String : AnyObject] = response.result.value as! [String : AnyObject]
                            if dictResponse[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                                let status = dictResponse[WEB_API_STATUS] as! String
                                success(status)
                            }else {
                                let error = dictResponse[WEB_API_STATUS] as! String
                                failure(error)
                            }
                        }
                        if response.response?.statusCode != 200 {
                            //error Message
                            let dictResponse : [String : AnyObject] = response.result.value as! [String : AnyObject]
                            let error = dictResponse[WEB_API_STATUS] as! String
                            failure(error)
                        }
                    }
                    break
                case .failure(let encodingError):
                    failure(encodingError.localizedDescription)
                    break
                }
        })
    }
   */
    
    
    
    
}// end Webserves 
