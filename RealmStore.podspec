Pod::Spec.new do |s|

  s.name = "RealmStore"
  s.version = "1.0.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = "A repository pattern implementation for Realm database"
  s.homepage = "https://github.com/vbicer/RealmStore"
  s.author = { "Volkan Bicer" => "vlknbcr@gmail.com" }
  s.source = { :git => 'https://github.com/vbicer/RealmStore.git', :tag => s.version.to_s }


  s.ios.deployment_target = '8.0'

  s.requires_arc = 'true'
  s.source_files = 'RealmStore/**/*.swift'
  s.dependency 'RealmSwift', '~> 2.1'
end
