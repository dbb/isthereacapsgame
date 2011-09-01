$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

Dir.glob('tasks/*.rake').each { |r| Rake.application.add_import r }

task :default => :test
