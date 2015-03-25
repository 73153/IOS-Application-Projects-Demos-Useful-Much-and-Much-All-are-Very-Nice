Pod::Spec.new do |s|
  s.name         = "LBReadingTime"
  s.version      = "0.0.1"
  s.summary      = "UITextView indicator's panel showing the remaing reading time."
  s.homepage     = "https://github.com/lukabernardi/LBReadingTime"
  s.author       = { "Luca Bernardi" => "luka.bernardi@gmail.com" }
  s.license      = "MIT"
  s.source       = { :git => "https://github.com/lukabernardi/LBReadingTime.git", :tag => "0.0.1" }
  s.platform     = :ios, '5.0'
  s.source_files = 'Classes', 'LBReadingTime/ReadingTime/*.{h,m}'
  s.frameworks   = 'QuartzCore', 'UIKit'
  s.requires_arc = true
end
