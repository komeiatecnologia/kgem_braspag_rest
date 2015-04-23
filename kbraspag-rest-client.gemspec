Gem::Specification.new do |s|
  s.name    = "kbraspag-rest-client"
  s.version = "0.0.1"
  s.description = "Cliente Braspag Pagador API REST que funciona no ruby 1.8 e atende as necessidades especiais da Komeia"
  s.summary = "API Pagamentos"
  s.author  = "Rafael Moraes"
  s.files = Dir["{lib/**/*.rb,*.gemspec}"]
  s.add_runtime_dependency 'json_pure', '~> 1.6', '<= 1.6.4'
  s.add_runtime_dependency 'ruby', '~> 1.8', '<= 1.8.7'
  .requirements << 'ruby, v1.8.7 EE'
end
