Pod::Spec.new do |s|
s.name         = "UCSDesktopLog"
s.version      = "1.0.0"
s.summary      = "桌面日志"
s.homepage     = "http://172.17.16.23:3000/Luzz/UCSDesktopLog"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author        = { "Luzz" => "lu.zizheng@ucsmy.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "http://172.17.16.23:3000/Luzz/UCSDesktopLog.git", :tag => s.version }
s.source_files = "UCSDesktopLog/UCSDesktopLog/*.{h,m}"
s.public_header_files = "UCSDesktopLog/UCSDesktopLog/*.{h}"
s.requires_arc = true
s.frameworks   = 'Foundation'
#s.dependency "UCSEncrypt"
end
