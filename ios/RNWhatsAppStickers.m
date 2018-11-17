#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(RNWhatsAppStickers, NSObject)

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

RCT_EXTERN_METHOD(createStickerPack:(NSDictionary *)config
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(addSticker:(NSString *)fileName
                  emojis:(NSArray *)emojis
                  resolver: (RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

RCT_EXTERN_METHOD(send:(RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject)

@end
