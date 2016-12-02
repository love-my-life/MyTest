Pod::Spec.new do |s|

  s.name         = "MyTest3"
  s.version      = "1.0.0"
  s.summary      = "learn"
  s.description  = <<-DESC
                   JHToast
		    DESC
  s.homepage     = "https://github.com/love-my-life/MyTest"
  s.license      = "MIT"
  s.author             = { "love-my-life" => "13298303056@163.com" }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/love-my-life/MyTest.git", :tag => s.version.to_s }
  s.source_files  = "JHToast/*.swift"

end
