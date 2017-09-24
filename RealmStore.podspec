Pod::Spec.new do |s|

  s.name = "RealmStore"
  s.version = "1.0.0"
  s.license = { :type => "WTFPL", :file => "LICENSE" }
  s.summary = "A repository pattern implementation for Realm database"
  s.homepage = "www.sozcu.com.tr"
  s.author = { "Volkan Bicer" => "vlknbcr@gmail.com" }
  s.source = { :path => '.' }

  s.ios.deployment_target = '8.0'

  s.requires_arc = 'true'
  s.source_files = 'RealmStore/**/*.swift'
  s.dependency 'RealmSwift', '~> 2.1'
end
