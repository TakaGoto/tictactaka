Gem::Specification.new do |s|
  s.version         = "0.0.0"
  s.name            = "taka_tic_tac_toe"
  s.description     = "tic tac toe engine"
  s.summary         = "a tic tac toe engine for console and sinatra app"
  s.authors         = "Taka Goto"
  s.email           = "tak.yuki@gmail.com"
  s.files           = %w( README.md Rakefile)
  s.files           += Dir.glob("lib/**/*")
  s.files           += Dir.glob("spec/**/*")

  s.add_dependency("cucumber", '>= 1.3.1')
  s.add_dependency("rspec", '>= 2.13.0')
  s.add_dependency("bundler", '>= 1.3.5')
end

