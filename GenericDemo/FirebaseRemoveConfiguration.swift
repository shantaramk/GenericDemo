//
//  FirebaseRemoveConfiguration.swift
//  DemoProject
//
//  Created by Shantaram Kokate on 7/20/18.
//  Copyright © 2018 US Interactive. All rights reserved.
//

import UIKit
 import FirebaseCore
 import FirebaseRemoteConfig

struct ParameterKey{
   static let image = "CONTEST_IMAGE"
   static let registercheck = "CANCEL_REGISTER_CHECK"
   static let terms = "CONTEST_TERMS"

}
class FirebaseRemoveConfiguration: NSObject {

    private let terms = " This contest is open only to legal residents of India and who are at least eighteen (18) years old at the time of entry.   ///You understand that Sourus is collecting your information so that you can participate in future promotions and surveys, and receive certain promotional communications from Sourus and its partners.   /// You further understand and agree that Sourus may share your personal or other information requested below with Sourus subsidiaries any of which may contact you to participate in surveys and to keep you informed about sourus related products, services, and other offerings via text messaging, postal mail or equivalent methods.   /// By providing your personal and other information requested below, you consent and agree to such sharing. In addition, Also understand that you can access, update, unsubscribe, and request to delete your personal and other information at any time.   /// TIMING: The promotion begins on June 6th , 2018 and ends on August 6th , 2018 (both days inclusive) (the Promotion Period). Sponsor's computer will be the official time-keeping device for this Promotion.   /// Prizes: Winner will receive cash prize or exclusive gifts from sourus.   /// We will randomly select the potential contest winners from all eligible entries received during the Promotion Period and from already registered users. The potential winners will be notified by e-mail. If any potential winner cannot be contacted, within the required time period, such potential winner forfeits prize without compensation of any kind.   /// Prizes cannot be replaced, exchanged, transferred or returned against their cash value.   /// The Prize only includes gratification and in no manner the Prize shall be given along with any seller's warranty and/or guarantee pertaining to (inclusive of but not limited to maintenance, exchange and servicing.   /// Our decision is final on all matters and no correspondence will be entered into. Entry into this competition will be deemed to be an acceptance of the above terms and conditions.   /// This Promotion is governed by the laws of The Republic Of India. "
     private let image  = "https://www.sourus.com/img/registernwin.jpg"
    
 
    var remoteConfig: RemoteConfig!
    static let sharedInstance = FirebaseRemoveConfiguration()
    
    private static var sharedNetworkManager: FirebaseRemoveConfiguration = {
        let networkManager = FirebaseRemoveConfiguration()
         return networkManager
    }()
    
    class func shared() -> FirebaseRemoveConfiguration {
        return sharedNetworkManager
    }
    override init() {
        super.init()
        // Use Firebase library to configure APIs
   
    }
    func initWithData() {
        FirebaseApp.configure()
        
        setupRemoteContiguration()
        loadDefaultValue()

        fetchCloudValue()
    }
    func setupRemoteContiguration() {
        self.remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = RemoteConfigSettings(developerModeEnabled: true)!

    }
    func loadDefaultValue() {
        let appDefualt :[String:String] = [ ParameterKey.terms :terms,
                                             ParameterKey.image : image,
                                             ParameterKey.registercheck : "0"
                                                ]
        self.remoteConfig.setDefaults(appDefualt as [String : NSObject])
  
    }
    func fetchCloudValue() {
        // TimeInterval is set to expirationDuration here, indicating the next fetch request will use
        // data fetched from the Remote Config service, rather than cached parameter values, if cached
        // parameter values are more than expirationDuration seconds old. See Best Practices in the
        let expirationDuration: TimeInterval = 0

        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                 self.remoteConfig.activateFetched()

            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            //self.displayWelcome()
        }
    }
    func string(forKey  key : String) ->  String {
        let message = remoteConfig[key].stringValue
        return message!
    }
 
}
