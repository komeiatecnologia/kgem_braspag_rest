require "rake/testtask"
import "lib/tasks/install.rake"

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = Dir["test/**/*_test.rb"]
end
