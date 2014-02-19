require 'motion-cocoapods'
require 'motion-prime'

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

Motion::Require.all(Dir.glob(File.expand_path('../prime_reside_menu/**/*.rb', __FILE__)))

Motion::Project::App.setup do |app|
  app.pods do
    # pod 'RESideMenu', git: 'git@github.com:droidlabs/RESideMenu.git'
    pod 'RESideMenu', path: '../RESideMenu'
  end
end