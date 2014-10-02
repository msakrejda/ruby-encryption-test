require "bundler"
Bundler.setup
require 'pg'
require 'sequel'
require 'fernet'

DB = Sequel.connect(ENV['DATABASE_URL'])

namespace :encrypt do
  task :test_fernet do
    require_relative './...'
    loop do
      Runner.new(FernetEncypted).run
    end
  end

  task :test_asym do
    require_relative './...'
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
    database_url = ENV['DATABASE_URL'] || 'postgres:///shogun'
    target_version = ENV['VERSION'].to_i if ENV['VERSION']
    DB = Sequel.connect(database_url, loggers: Logger.new(STDOUT))
    Sequel::Migrator.apply(DB, 'migrations', target_version)
  end
end
