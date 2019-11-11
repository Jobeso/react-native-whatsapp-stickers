require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-whatsapp-stickers"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  Integrate sticker packs for WhatsApp with your react-native app
                   DESC
  s.homepage     = "https://github.com/Jobeso/react-native-whatsapp-stickers"
  s.license      = { :type => "BSD", :file => "LICENSE" }
  s.authors      = { "Johannes Sorg" => "johannes@sorg.me" }
  s.platforms    = { :ios => "9.0", :tvos => "10.0" }
  s.source       = { :git => "https://github.com/Jobeso/react-native-whatsapp-stickers.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "libwebp"

  s.ios.framework = "UIKit"
  s.ios.framework = "CoreFoundation"
  s.ios.framework = "QuartzCore"
  s.ios.framework = "AssetsLibrary"
  s.ios.framework = "ImageIO"
  s.ios.framework = "Accelerate"
  s.ios.framework = "MobileCoreServices"
  s.ios.framework = "libz.tbd"
end
