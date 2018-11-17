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
    @objc func addStickers(name: String, location: String, date: NSNumber) -> Void {
        NSLog("%@ %@ %S", name, location, date);
    }
    
    @objc func createStickerPack(name: String, location: String, date: NSNumber) -> Void {
        NSLog("%@ %@ %S", name, location, date);
        do {
            let stickerPack = try StickerPack(identifier: "identifier",
                            name: "sticker pack name",
                            publisher: "sticker pack publisher",
                            trayImageFileName: "tray image file name",
                            publisherWebsite: "publisher website URL",
                            privacyPolicyWebsite: "privacy policy website URL",
                            licenseAgreementWebsite: "license agreement website URL")
        } catch {
            NSLog("error");
            // TODO error handling
        }
    }
    
}
