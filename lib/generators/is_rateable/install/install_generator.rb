module IsRateable
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    class_option :id_column_type, type: :string, aliases: '-id', default: 'integer', desc: 'Column type used for ids. Either integer(default) or uuid'
    desc 'Add the ratings table, allowing models to be rated.'

    source_root File.expand_path('../templates', __FILE__)

    def create_initializer
      template 'initializer.rb', 'config/initializers/is_rateable.rb'
    end

    def copy_migrations
      migration_template 'migration_ratings.rb', "db/migrate/create_is_rateable_ratings.rb"
    end

    # Implement the required interface for Rails::Generators::Migration.
    def self.next_migration_number(dirname)
      next_migration_number = current_migration_number(dirname) + 1
      if ActiveRecord::Base.timestamped_migrations
        [Time.now.utc.strftime('%Y%m%d%H%M%S'), '%.14d' % next_migration_number].max
      else
        '%.3d' % next_migration_number
      end
    end
  end
end
