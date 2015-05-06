namespace :kbraspag do
  desc "Execute após instalar a GEM KBraspag Rest Client"
  task :install do
    File.exist("config/initializers")
  end
end
