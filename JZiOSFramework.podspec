Pod::Spec.new do |s|
  s.name         = "JZiOSFramework"
  s.version      = "1.0.0"
  s.summary      = "Basic framework for iOS Swift"
  s.homepage = "https://github.com/zjfjack/JZiOSFramework"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Jeff Zhang" => "zekejeff@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source = { :git => "https://github.com/zjfjack/JZiOSFramework.git", :tag => s.version }
  s.source_files  = "JZiOSFramework/**/*.swift"
end