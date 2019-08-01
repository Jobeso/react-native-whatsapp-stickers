
Pod::Spec.new do |s|
  s.name         = "RNWhatsAppStickers"
  s.version      = "1.0.0"
  s.summary      = "RNWhatsAppStickers"
  s.description  = <<-DESC
                  RNWhatsAppStickers
                   DESC
  s.homepage     = "https://github.com/Jobeso/react-native-whatsapp-stickers"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "author@domain.cn" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/author/RNWhatsAppStickers.git", :tag => "master" }
  s.source_files  = "RNWhatsAppStickers/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  
