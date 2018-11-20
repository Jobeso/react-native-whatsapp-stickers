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
4. select `WebP.framework` and click open

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
4. check `Copy Items If Needed` on the dialogue that pops up

**Done 🎉**

## Usage

### Methods

1. Create a sticker pack
```javascript
import RNWhatsAppStickers from "react-native-whatsapp-stickers"

cosnt config = {
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

### Example

#### App.js
```javascript
import RNWhatsAppStickers from "react-native-whatsapp-stickers"
import { stickerConfig } from "./stickerConfig"

const { stickers, ...packConfig } = stickerConfig

RNWhatsAppStickers.createStickerPack(packConfig)
  .then(() => {
    const promises = stickers.map(item =>
      RNWhatsAppStickers.addSticker(item.fileName, item.emojis)
    )

    Promise.all(promises).then(() => RNWhatsAppStickers.send())
  })
  .catch(e => console.log(e))
```

#### stickerConfig.js
```javascript
export const stickerConfig = {
  identifier: 'com.myproject.app.stickers',
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
      emojis: ['😎'],
    },
```

## Roadmap
- Android support
- Method to check if WhatsApp is installed
