Pod::Spec.new do |s|
s.name         = "UCSDesktopLog"
s.version      = "1.0.1"
s.summary      = "ios dubug log on mac desktop"
s.homepage     = "https://github.com/luzizheng/UCSDesktopLog"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author        = { "Luzz" => "lu.zizheng@ucsmy.com" }
s.platform     = :ios, "8.0"
s.ios.deployment_target = '8.0'
 s.osx.deployment_target = '10.8'
s.source       = { :git => "https://github.com/luzizheng/UCSDesktopLog.git", :tag => s.version }
s.source_files = "UCSDesktopLog/UCSDesktopLog/*.{h,m}"
s.public_header_files = "UCSDesktopLog/UCSDesktopLog/*.{h}"
s.requires_arc = true
s.frameworks   = 'Foundation'
#s.dependency "UCSEncrypt"
end
