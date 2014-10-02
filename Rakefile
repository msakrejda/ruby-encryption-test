require "bundler"
Bundler.setup
require 'pg'
require 'sequel'
require 'fernet'

DB = Sequel.connect(ENV['DATABASE_URL'])

namespace :encrypt do
  require_relative './secret'
  require_relative './fernet_encrypted'
  require_relative './asym_encrypted'
  require_relative './step'
  require_relative './runner'


  task :test_fernet do
    loop do
      Runner.new(FernetEncypted).run
    end
  end

  task :test_asym do
    loop do
      Runner.new(AsymEncrypted).run
    end
  end
end

namespace :db do
  desc 'Migrate the database'
  task :migrate do
    require 'logger'
    require 'sequel'
    require 'sequel/extensions/migration'
    database_url = ENV['DATABASE_URL']
    DB = Sequel.connect(database_url, loggers: Logger.new(STDOUT))
    Sequel::Migrator.apply(DB, 'migrations')
  end
end
