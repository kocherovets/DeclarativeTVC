Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11'
s.name = "DeclarativeTVC"
s.summary = "Declarative working with UIKit collections."
s.requires_arc = true

s.license = { :type => "MIT", :file => "LICENSE" }
s.homepage = 'https://github.com/kocherovets/DeclarativeTVC'
s.author = { 'Dmitry Kocherovets' => 'kocherovets@gmail.com' }

s.version = "1.0.22"
s.source = { :git => 'https://github.com/kocherovets/DeclarativeTVC.git', :tag => s.version.to_s  }
s.source_files = "Sources/**/*.{swift}"

s.swift_version = "5.0"

s.framework = "UIKit"

s.dependency 'DifferenceKit'

end
