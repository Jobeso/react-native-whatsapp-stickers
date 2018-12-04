//
//  RNWhatsAppStickers.swift
//  RNWhatsAppStickers
//
//  Created by Johannes Sorg on 04.11.18.
//  Copyright © 2018 Facebook. All rights reserved.
//

import Foundation

@objc(RNWhatsAppStickers)
class RNWhatsAppStickers: NSObject {
    var stickerPack: StickerPack!;
   
    @objc
    func createStickerPack(_ config: NSDictionary,
                           resolver resolve: RCTPromiseResolveBlock,
                           rejecter reject: RCTPromiseRejectBlock) -> Void {
        do {
            stickerPack = try StickerPack(identifier: RCTConvert.nsString(config["identifier"]),
                            name: RCTConvert.nsString(config["name"]),
                            publisher: RCTConvert.nsString(config["publisher"]),
                            trayImageFileName: RCTConvert.nsString(config["trayImageFileName"]),
                            publisherWebsite: RCTConvert.nsString(config["publisherWebsite"]),
                            privacyPolicyWebsite: RCTConvert.nsString(config["privacyPolicyWebsite"]),
                            licenseAgreementWebsite: RCTConvert.nsString(config["licenseAgreementWebsite"]))
            resolve("success")

        } catch {
            NSLog("\(error)")
            reject("RNWhatsAppStickers", "an unknown error occured for whats app stickers", error)
        }
    }
    
    @objc
    func addSticker(_ fileName: String,
                    emojis: Array<String>,
                    resolver resolve: RCTPromiseResolveBlock,
                    rejecter reject: RCTPromiseRejectBlock){
        do {
            try stickerPack.addSticker(contentsOfFile: fileName,
                                   emojis: emojis)
            resolve("success")
        } catch {
            NSLog("\(error)")
            reject("RNWhatsAppStickers", "an unknown error occured for whats app stickers", error)
        }
    }
    
    @objc
    func send(_ resolve: @escaping RCTPromiseResolveBlock,
              rejecter reject: @escaping RCTPromiseRejectBlock) {
        stickerPack.sendToWhatsApp { completed in
            if(completed){
                resolve("success")
            }else{
                let error = NSError(domain: "", code: 200, userInfo: nil)
                reject("RNWhatsAppStickers", "an unknown error occured for whats app stickers", error)
            }
        }
    }
    
}
