# RNWhatsAppStickers
## Getting started

`$ npm install react-native-whatsapp-stickers --save`

or

`$ yarn add react-native-whatsapp-stickers`

## Installation

1. Either choose `Mostly automatic installation` or `Manual installation`
2. Follow the `Integration` guide

### Mostly automatic installation

`$ react-native link react-native-whatsapp-stickers`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-whatsapp-stickers` and add `RNWhatsAppStickers.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNWhatsAppStickers.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`

- Add `import com.jobeso.RNWhatsAppStickers.RNWhatsAppStickersPackage;` to the imports at the top of the file
- Add `new RNWhatsAppStickersPackage()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:
   ```
   include ':react-native-whatsapp-stickers'
   project(':react-native-whatsapp-stickers').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-whatsapp-stickers/android')
   ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
   ```
     compile project(':react-native-whatsapp-stickers')
   ```

## Integration

**Important**
Please make sure you follow the requirements for sticker packs from WhatsApp. You can find them [here for iOS](https://github.com/WhatsApp/stickers/tree/master/iOS#sticker-art-and-app-requirements) and [here for Android](https://github.com/WhatsApp/stickers/tree/master/Android#sticker-art-and-app-requirements).

### iOS

#### Swift

1. Under `Build Settings` section `Build Options` set `Always Embed Swift Started Libraries` to `true`
2. Make sure you have the following under `library search paths`

```
$(inherited)
$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)
```

#### Add frameworks 
Add the following frameworks under `General -> Linked Frameworks and Libraries`

```
UIKit
CoreFoundation
QuartzCore
AssetsLibrary
ImageIO
Accelerate
MobileCoreServices
libz.tbd
```

#### integrate WebP Framework
1. click on the + to add a new framework to `General -> Linked Frameworks and Libraries`
2. click on `Add other...`
3. navigate to `your-project/node_modules/react-native-whatsapp-stickers/iOS/Frameworks/`
4. select `WebP.framework` and click `Open`
5. add `"$(SRCROOT)/../node_modules/react-native-whatsapp-stickers/ios"` with `recursive` in `Build Settings -> Framework Search Paths`

#### Info.plist
- Add the following to your `Info.plist`
```
<key>LSApplicationQueriesSchemes</key>
  <array>
  <string>whatsapp</string>
</array>
```

#### Your Sticker Images
1. make sure they follow the guidelines from WhatsApp
2. Put the images somewhere in your project directory
3. drag and drop them into your XCode Project (recommended to a new folder)
4. check `Copy Items If Needed` in the dialogue that pops up and click `Finish`

**Done 🎉**

### Android

1. Create a `contents.json` file in `yourproject -> android -> app -> src -> main -> assets` following the following scheme.
**Improtant! Including dots in the identifier is causing troubles.**
```json
{
  "android_play_store_link": "https://play.google.com/store/apps/details?id=com.myapp",
  "ios_app_store_link": "https://itunes.apple.com/app/myapp/id123456",
  "sticker_packs": [
    {
      "identifier": "myprojectstickers",
      "name": "MyProject Stickers",
      "publisher": "John Doe",
      "tray_image_file": "tray_icon.png",
      "publisher_email": "contact@myproject.com",
      "publisher_website": "https://myproject.com",
      "privacy_policy_website": "https://myproject.com/legal",
      "license_agreement_website": "https://myproject.com/license",
      "stickers": [
        {
          "image_file": "01_sticker.webp",
          "emojis": ["✌️"]
        },
        {
          "image_file": "02_sticker.webp",
          "emojis": ["😍","😻"]
        },
        {
          "image_file": "03_sticker.webp",
          "emojis": ["😎"]
        }
      ]
    }
  ]
}
```

2. Place the WebP images in a folder with **with the same name** that you defined as `identifier` in the object above under the same directory. So your `assets` folder has the following structure:

```
assets
+-- contents.json
+-- identifier
|   +-- 01_sticker.webp
|   +-- 02_sticker.webp
|   +-- 03_sticker.webp
```

3. Add `noCompress` to your app `build.gradle` in `yourproject -> android -> app`
```gradle
android {
    ...
    aaptOptions {
        noCompress "webp"
    }
    ...
```

**Done 🎉**

## Usage

### Methods

Check if WhatsApp is available
```javascript
RNWhatsAppStickers.isWhatsAppAvailable()
  .then(isWhatsAppAvailable => console.log('available:', isWhatsAppAvailable))
  .catch(e => console.log(e))
```

#### iOS

1. Create a sticker pack
```javascript
import RNWhatsAppStickers from "react-native-whatsapp-stickers"

const config = {
  identifier: '',
  name: '',
  publisher: '',
  trayImageFileName: '',
  publisherEmail: '',
  publisherWebsite: '',
  privacyPolicyWebsite: '',
  licenseAgreementWebsite: '',
}

RNWhatsAppStickers.createStickerPack(config)
  .then(() => console.log('success'))
  .catch(e => console.log(e))
```

2. Add sticker
```javascript
RNWhatsAppStickers.addSticker('stickername.png', ['😎'])
  .then(() => console.log('success'))
  .catch(e => console.log(e))
```

3. Send to WhatsApp
```javascript
RNWhatsAppStickers.send()
  .then(() => console.log('success'))
  .catch(e => console.log(e))
```

#### Android
You are already good to go with the sticker pack creation if you followed the `Integration` part.

1. Send to WhatsApp where `name` and `identifier` represent the values you defined in `contents.json`
```javascript
RNWhatsAppStickers.send('identifier', 'name')
  .then(() => console.log('success'))
  .catch(e => console.log(e))
```

### Example

#### App.js
```javascript
import { Platform } from "react-native";
import RNWhatsAppStickers from "react-native-whatsapp-stickers"
import { stickerConfig } from "./stickerConfig"

const { stickers, ...packConfig } = stickerConfig

RNWhatsAppStickers.isWhatsAppAvailable()
  .then(isWhatsAppAvailable => {
    if (isWhatsAppAvailable) {
      if (Platform.OS === 'ios') {
        return RNWhatsAppStickers.createStickerPack(packConfig)
          .then(() => {
            const promises = stickers.map(item =>
              RNWhatsAppStickers.addSticker(item.fileName, item.emojis)
            )
            Promise.all(promises).then(() => RNWhatsAppStickers.send())
          })
          .catch(e => console.log(e))
      }

      return RNWhatsAppStickers.send('myprojectstickers', 'MyProject Stickers')
    }

    return undefined
  })
  .catch(e => console.log(e))
```

#### stickerConfig.js
```javascript
export const stickerConfig = {
  identifier: 'myprojectstickers',
  name: 'MyProject Stickers',
  publisher: 'John Doe',
  trayImageFileName: 'tray_icon.png',
  publisherEmail: 'contact@myproject.com',
  publisherWebsite: 'https://myproject.com',
  privacyPolicyWebsite: 'https://myproject.com/legal',
  licenseAgreementWebsite: 'https://myproject.com/license',
  stickers: [
    {
      fileName: '01_sticker.png',
      emojis: ['✌️'],
    },
    {
      fileName: '02_sticker.png',
      emojis: ['😍', '😻'],
    },
    {
      fileName: '03_sticker.png',
      emojis: ['😎']
    }
  ]
}
```

## Troubleshooting
<details>
  <summary>ld: warning: Could not find auto-linked library 'swiftFoundation'</summary>
  
  - Create an empty swift file in your project

  `xCode -> Click File -> new File -> empty.swift`

  **Important** Click yes when it asks for creating bridge-headers
</details>

## Roadmap
- Native implementation of method to check if WhatsApp is installed
- Consistend react-native api
