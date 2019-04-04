import React, { useEffect, useState } from 'react'
import { Alert, Button, Platform, Text, View } from 'react-native'
import RNWhatsAppStickers from 'react-native-whatsapp-stickers'

const config = {
  identifier: 'myprojectstickers',
  name: 'MyProject Stickers',
  publisher: 'John Doe',
  trayImageFileName: 'tray_Cuppy.png',
  publisherEmail: 'xyz@myproject.xy',
  publisherWebsite: 'https://github.com/Jobeso/react-native-whatsapp-stickers',
  privacyPolicyWebsite:
    'https://github.com/Jobeso/react-native-whatsapp-stickers',
  licenseAgreementWebsite:
    'https://github.com/Jobeso/react-native-whatsapp-stickers/blob/master/LICENSE',
  stickers: [
    {
      fileName: '01_Cuppy_smile.png',
      emojis: ['☕', '🙂'],
    },
    {
      fileName: '02_Cuppy_lol.png',
      emojis: ['😄', '😀'],
    },
    {
      fileName: '03_Cuppy_rofl.png',
      emojis: ['😆', '😂'],
    },
  ],
}

const { stickers, ...packConfig } = config

const logError = e => {
  console.log(e)
  Alert.alert('Error', e.message)
}

const sendStickerPack = () => {
  if (Platform.OS === 'ios') {
    RNWhatsAppStickers.createStickerPack(packConfig)
      .then(() => {
        const promises = stickers.map(item =>
          RNWhatsAppStickers.addSticker(item.fileName, item.emojis)
        )
        Promise.all(promises).then(() => RNWhatsAppStickers.send())
      })
      .catch(logError)
  } else {
    RNWhatsAppStickers.send('myprojectstickers', 'MyProject Stickers')
      .then(() => console.log('success'))
      .catch(logError)
  }
}

const TextBold = ({ children }) => (
  <Text style={{ fontWeight: 'bold', fontSize: 16 }}>{children}</Text>
)

export const App = () => {
  const [isAvailable, setIsAvailable] = useState(false)

  useEffect(() => {
    RNWhatsAppStickers.isWhatsAppAvailable()
      .then(setIsAvailable)
      .catch(logError)
  }, [])

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text style={{ fontSize: 28, fontWeight: 'bold', marginBottom: 48 }}>
        RNWhatsAppStickers
      </Text>
      <Text style={{ marginBottom: 24, fontSize: 16 }}>
        WhatsApp is{' '}
        {isAvailable ? (
          <TextBold>available</TextBold>
        ) : (
          <TextBold>not available</TextBold>
        )}
      </Text>
      {isAvailable && (
        <Button title="Send Stickers" onPress={sendStickerPack} />
      )}
    </View>
  )
}
