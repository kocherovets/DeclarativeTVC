source 'https://github.com/CocoaPods/Specs.git'
workspace 'DeclarativeTVC'
platform :ios, '11.0'
inhibit_all_warnings!
use_frameworks!

def shared_pods
    pod 'DifferenceKit'
end

target "DeclarativeTVC" do
    project 'DeclarativeTVC'

    shared_pods
end

target "DeclarativeTVCTests" do
    project 'DeclarativeTVC'

    shared_pods
end

target "DeclarativeTVCUITests" do
    project 'DeclarativeTVC'

    shared_pods
end

target "Framework" do
    project 'DeclarativeTVC'

    shared_pods
end
