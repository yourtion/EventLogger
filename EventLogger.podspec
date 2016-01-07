Pod::Spec.new do |s|

  s.name         = "EventLogger"
  s.version      = "0.3.1"
  s.summary      = "Log event count and event time in iOS."

  s.description  = <<-DESC
                   Log event count and event time in iOS.
                    Log time and events
                   DESC

  s.homepage     = "https://github.com/yourtion/EventLogger"
  s.screenshots  = "https://raw.githubusercontent.com/yourtion/EventLogger/master/ScreenShot/ScreenShot1.JPG"
  s.license      = "Apache License, Version 2.0"
  s.author             = { "Yourtion" => "yourtion@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yourtion/EventLogger.git", :tag => "0.3.1" }
  s.source_files  = "EventLogger"
  s.frameworks  = "Foundation"
  s.requires_arc = true

end
