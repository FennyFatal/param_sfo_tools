Gem::Specification.new do |s|
  s.name        = 'param_sfo'
  s.add_runtime_dependency 'bindata', '~> 2.4', '>=2.4.3'
  s.add_runtime_dependency 'http', '~> 3.3', '>=3.3.0'
  s.executables << 'get_sfo_info'
  s.version     = '0.0.1'
  s.date        = '2018-06-07'
  s.summary     = "Param.sfo"
  s.description = "A simple parser utility for param.sfo"
  s.authors     = ["Fenny Fatal"]
  s.email       = 'fenny@fennyfatal.com'
  s.files       = ["lib/SFO.rb"]
  s.homepage    = 'http://rubygems.org/gems/param_sfo'
  s.license     = 'MIT'
end
