Pod::Spec.new do |s|
  s.name             = "ResponderChain"
  s.version          = "1.0.2"
  s.license          = { :type => "MIT" }
  s.homepage         = "https://github.com/GodL/ResponderChain"
  s.author           = { "GodL" => "547188371@qq.com" }
  s.summary          = "ResponderChain is a library that passes events using the responder chain."

  s.source           = { :git => "https://github.com/GodL/ResponderChain.git", :tag => "#{s.version}" }
  s.source_files     = "Sources/ResponderChain/*.swift"
  
  s.swift_version    = "5.0"

  s.ios.deployment_target = "9.0"
end
