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
    
    //1 Signin   ===> DONE
    //2 SignUp Consumer  ==== > Not Working == >> Data parsing remainig
    //3 SignUp Business ==== > Not Working === >> Data Parsing remaning
    //4 category_list ==== > Working
    
    //6 get_profile ====> Not Implementation ===> Working ===> Data parsing Remainig
    //7 tag_list ======> Working =====>  Data parsing remainig
    
    //8 commons/feeds call home consumnerHome
    //===>
    
    
    
    // BUSINESSS
    //9 feeds
    //5 create_feed  ====> Not Implementation ===> Not Working  == >> Data parsing remaining
    // 10 delete business feed
    //1 Signin
    
    
    // CONSUMER



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
                        latitude: Double,
                        longitude: Double,
                        accuracy: Double,
                        tags:[String],
                        success: @escaping(_ success: User)-> Void,
                        failure: @escaping(_ failure: String)-> Void) {
        
        let parameters = ["user_name": user_name,
                         "email": email,
                         "password": password,
                         "mobile": mobile,
                         "type": type,
                         "latitude": latitude,
                         "longitude": longitude,
                         "accuracy": accuracy,
                         "tags": [tags]] as [String : Any]
        
        Alamofire.request("https://biz-gadget.herokuapp.com/api/commons/signup",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil).responseJSON {
                
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
/*
     name:Yogesh
     email:yogesh@gmaul.com
     country:India
     state:Maharashtra
     city:Pune
     phone:9922790989
     message:Hi
 */
    
    // Contact Us
    func contactUs(name:String,
                   email:String,
                   country:String,
                   state:String,
                   city:String,
                   phone:String,
                   message:String,
                   success:@escaping(_ success:String)->Void,
                   failure:@escaping(_ failure:String)->Void) {
        
        let dictParam:[String:String]=["name":name,
                                       "email":email,
                                       "country":country,
                                       "state":state,
                                       "city":city,
                                       "phone":phone,
                                       "message":message
                                       ]
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request(WEB_CONTACT,
            method: .post,
            parameters: dictParam,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                if response.result.isSuccess {
                  print("Response=\(response.result.value ?? "Not yet")")
                    let response:[String:Any] = response.result.value as! [String:Any]
                    if response["result"] as! Bool == true{
                        success(response["message"] as? String  ?? "Success")
                    } else {
                        failure("Error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "ERROR")
                }
        }
        
    }
        
       //4 category_list
    func categoryList(header:[String:String],
        success: @escaping(_ success: [category_data])-> Void,
                          failure: @escaping(_ failure: String)->Void) {
        
            Alamofire.request("\(WEB_API_URL)category_list",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default,
                headers: header).responseJSON {
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
    
    
    

    
     //6 get_profile
    func getProfile(headerParam:[String:String],
                    success:@escaping(_ success: String)-> Void,
                    failure:@escaping(_ failure:String)-> Void) {
        
        Alamofire.request("\(WEB_API_URL)get_profile",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("get_profile Response = \(response.result.value ?? "Not yet")")
        }
    }
    
    
    
    
    
    //7 tag_list
    func tagLidt(headerParam:[String: String],
                 success:@escaping(_ success: [String])->Void,
                 failure:@escaping(_ failure:String)->Void) {
        
        Alamofire.request("\(WEB_API_URL)tag_list",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("Response tag_list =\(response.result.value ?? "Error")")
                if response.result.isSuccess {
                    
                    guard let data = response.data else {
                        failure("No data found")
                        return
                    }
                    
                    do {
                        let tagList = try JSONDecoder().decode(TagList.self, from: data)
                        if tagList.messsage == nil {
                            success(tagList.list!)
                        } else {
                            failure("Json Error...")
                        }
                    }  catch {
                        failure("Json Error")
                    }
                }
                
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "ERROR")
                }
        }
    }

    
    
    //5 create_feed
    func createNewFeed(title: String,
                       detail: String,
                       category: String,
                       date: String,
                       latitude: String,
                       longitude: String,
                       accuracy: Double,
                       user_id: Int,
                       logo: UIImage,
                       image: UIImage,
                       success: @escaping(_ success: String)->Void,
                       failure: @escaping(_ failure: String)->Void) {
        
        let parameter : [String: Any] = ["title":title,
                                         "detail":detail,
                                         "category":category,
                                         "date":date,
                                         "latitude":latitude,
                                         "longitude":longitude,
                                         "accuracy":accuracy,
                                         "user_id":user_id
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            let name = self.randomString(length: 8)
            let name1 = self.randomString(length: 8)
            multipartFormData.append(UIImageJPEGRepresentation(logo , 0.5)!, withName: "logo",
                                     fileName: "image\(name).jpg",mimeType: "image/jpeg")
            
            multipartFormData.append(UIImageJPEGRepresentation(image , 0.5)!, withName: "image",
                                     fileName: "image\(name1).jpg", mimeType: "image/jpeg")
            
            for (key, value) in parameter {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
        }, usingThreshold:UInt64.init(),
           to: "\(WEB_API_URL)create_feed",
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
                        
                        print("Response create_feed =\(response.result.value ?? "Not yet ")")
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
    
    
    //======= CONSUMER
    // 8 commons/feeds
    func getConsumerAllFeed(success: @escaping(_ success :[Feed])->Void,
                            failure: @escaping(_ failure: String)-> Void)  {
        
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request("\(WEB_API_URL_CUS)feeds",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("Response =\(response.result.value ?? "Not")")
                
                if response.result.isSuccess {
                    guard let data = response.data else {
                        failure("No data found")
                        return
                    }
                    do {
                        let feedList = try JSONDecoder().decode(FeedResponse.self, from: data)
                        if feedList.result ?? false {
                            success(feedList.list!)
                        }
                    } catch {
                        failure("Json error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "ERROR" )
                }
        }
        
    }
    
    
    //favourite_list Home Page consumer
    func FavouritesList(success:@escaping(_ success:[Favourite])->Void,
                        failure:@escaping(_ failure:String)->Void) {
        
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request("\(WEB_API_URL_CUS)favourite_list",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                
                print("RESPONSE = \(response.result.value ?? "ERROR")")
                
                if response.result.isSuccess {
                    guard let data = response.data else {return}
                    do{
                        let favourit = try JSONDecoder().decode(FavouriteRes.self, from: data)
                        if favourit.result ?? false {
                            success(favourit.list!)
                        } else {
                            failure("No Data Founr")
                        }
                        
                    } catch {
                        failure("Json error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "ERROR")
                }
        }
        
    }
    
    //https://biz-gadget.herokuapp.com/api/consumers/create_favourite
    func createFavourite(name:String,
                         user_id:Int,
                         success:@escaping(_ success:String)-> Void,
                         failure:@escaping(_ failure:String)->Void) {
        
        let dictParam:[String:Any] = ["name":name,
                                     "user_id":user_id]
        
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request("\(WEB_API_URL_CUS)create_favourite",
            method: .post,
            parameters: dictParam,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("Response =\(response.result.value ?? "Nil")")
                if response.result.isSuccess {
                    let response:[String:Any] = response.result.value as! [String:Any]
                    if response["result"] as! Bool == true{
                        success(response["message"] as? String  ?? "Success")
                    } else {
                        failure("Error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "Error")
                }
        }
    }

    
    
    
     //https://biz-gadget.herokuapp.com/api/consumers/set_favourite
    func setFavourite(feedId:Int,
                      favouriteId:Int,
                      success:@escaping(_ success:String)->Void,
                      failure:@escaping(_ failure:String)->Void) {
        
        let dictParam:[String:Any] = ["feed_id":feedId,
                                      "favourite_id":favouriteId]
        
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request("\(WEB_API_URL_CUS)set_favourite",
            method: .post,
            parameters: dictParam,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("Response =\(response.result.value ?? "Nil")")
                if response.result.isSuccess {
                    let response:[String:Any] = response.result.value as! [String:Any]
                    if response["result"] as! Bool == true{
                        success(response["message"] as? String  ?? "Success")
                    } else {
                        failure("Error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "Error")
                }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // BUSINESS
    
    //9 feeds // https://biz-gadget.herokuapp.com/api/businesses/feeds
    // show home page to display data
    func businessFeeds(headerParam:[String:String],
                       success:@escaping(_ success:[Feed])->Void,
                       failure:@escaping(_ failure:String)->Void) {
        
        Alamofire.request("\(WEB_APIURL_BUS)feeds",
            method: .post,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: headerParam).responseJSON {
                response in
                print("\n Response =\(response.result.value ?? "Not")")
                
                if response.result.isSuccess {
                    guard let data = response.data else {
                        failure("No Data found")
                        return
                    }
                    do {
                        let feedList = try JSONDecoder().decode(FeedResponse.self, from: data)
                        if feedList.result ?? false {
                            success(feedList.list!)
                        }
                    }catch {
                        failure("Json Error")
                    }
                }
                if response.result.isFailure {
                    failure(response.result.error?.localizedDescription ?? "Error")
                }
        }
    }
    
    
    // 10 delete business feed
    func deleteBusinessFeed(id:Int,
                            success: @escaping(_ success:String)->Void,
                            failure: @escaping(_ failure:String)->Void) {
        
        let parameter:[String:Int] = ["id":id]
        let kay = UserDefaults.standard.string(forKey: "authkey")
        let headerParam:[String:String] = ["Content-Type":"application/x-www-form-urlencoded",
                                           WEB_TOKEN:kay ?? " "]
        
        Alamofire.request("\(WEB_API_URL)delete_feed",
                          method: .post,
                          parameters: parameter,
                          encoding: URLEncoding.default,
                          headers: headerParam).responseJSON {
                            response in
                            print("Response = \(response.result.value ?? "Error Not Display")")
                            if response.result.isSuccess {
                                let response:[String:Any] = response.result.value as! [String:Any]
                                if response["result"] as! Bool == true{
                                    success(response["message"] as? String  ?? "Success")
                                } else {
                                    failure("Error")
                                }
                            }
                            if response.result.isFailure {
                               failure(response.result.error?.localizedDescription ?? "ERROR")
                            }
        }
    }
    
    
    /*
     
     Json:  {"title": "my feed", "detail": "My first feed", "category_id": 2, "date": "2018-08-26 17:45:01.67464", "latitude": "18.654933", "longitude": "73.80768", "accuracy": "15.0", "user_id": 1, “logo”:  image0, “image”: image1 }

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
