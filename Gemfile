source 'http://rubygems.org'

gem 'rhoconnect', '3.1.1'

# Helps with some of the limitations of green threads, not needed in ruby 1.9.x
gem 'SystemTimer', '~> 1.2.3', :platforms => :ruby_18
gem 'win32-process', :platforms => [:mswin, :mingw]

platforms :jruby do
  gem 'jdbc-sqlite3', ">= 3.7.2"
  gem 'dbi', ">= 0.4.5"
  gem 'dbd-jdbc', ">= 0.1.4"
  gem 'jruby-openssl', ">= 0.7.4"
  gem 'trinidad'
  gem 'warbler'
end

gem 'sqlite3', ">= 1.3.3", :platforms => [:ruby, :mswin, :mingw]

group :development do
  # FIXME: At this moment (01/10/2012) only pre release of 'eventmachine' is working on Windows
  gem 'eventmachine', '~> 1.0.0.beta', :platforms => [:mswin, :mingw]
  # By default to run application thin web server is used
  gem 'thin', :platforms => [:ruby, :mswin, :mingw]
  gem 'rhomobile-debug', ">= 1.0.2"
end

group :test do
  gem 'rack-test', '>= 0.5.3', :require => "rack/test"
  gem 'rspec', '~> 2.6.0'
  gem 'rhomobile-debug', ">= 1.0.2"
end
