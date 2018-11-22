import { Linking, NativeModules } from 'react-native'

const { RNWhatsAppStickers } = NativeModules

const isWhatsAppAvailable = () =>
  new Promise((resolve, reject) =>
    Linking.canOpenURL('whatsapp://send')
      .then(supported => resolve(supported))
      .catch(e => reject(e))
  )

export default { ...RNWhatsAppStickers, isWhatsAppAvailable }
