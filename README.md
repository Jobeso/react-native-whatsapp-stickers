# react-native-whats-app-stickers

## Getting started

`$ npm install react-native-whats-app-stickers --save`

### Mostly automatic installation

`$ react-native link react-native-whats-app-stickers`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-whats-app-stickers` and add `RNWhatsAppStickers.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNWhatsAppStickers.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`

- Add `import com.reactlibrary.RNWhatsAppStickersPackage;` to the imports at the top of the file
- Add `new RNWhatsAppStickersPackage()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:
   ```
   include ':react-native-whats-app-stickers'
   project(':react-native-whats-app-stickers').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-whats-app-stickers/android')
   ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
   ```
     compile project(':react-native-whats-app-stickers')
   ```

## Usage

```javascript
import RNWhatsAppStickers from "react-native-whats-app-stickers";

// TODO: What to do with the module?
RNWhatsAppStickers;
```

## Troubleshooting

- Add `$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)` to your library search paths when you never integrated swift Before
- Add `use_frameworks!` when integrating with Pods
