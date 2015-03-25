Pod::Spec.new do |s|
  s.name         = "MBAlertView"
  s.version      = "1.3.0"
  s.summary      = "Fast, fun, and simple block-based alerts and HUDs."
  s.description  = <<-DESC
                    MBAlertView is a fun and simple block-based alert and HUD library for iOS, as seen in Notestand.
                   DESC
  s.homepage     = "https://github.com/mobitar/MBAlertView"
  s.license      = 'MIT'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Mo Bitar" => "me@mbbitar.com" }
  s.source       = { :git => "https://github.com/cabbiepete/MBAlertView.git", :tag => "1.3.0" }
  s.platform     = :ios

  s.source_files = 'MBAlertView/**/*.{h,m}'

  s.frameworks  = 'QuartzCore', 'Accelerate'

  s.requires_arc = true
end
