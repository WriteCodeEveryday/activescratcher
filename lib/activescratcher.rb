require "activescratcher/engine"

module ActiveScratcher
  class Scratch
    @supported_db_types = []
    def self.execute(options={})
      # Parameter passing
      # => I_HAVE_BEEN_TOLD_OF_THE_RISKS_AND_UNDERSTAND_RUNNING_THIS_IN_PRODUCTION_IS_SUPER_DUMB - Run in Production Mode
      # => children - How many Children Should Be Generated For Each ActiveRecord "has_many" Relation
      # => exclusions - What Classes Should Be Excluded from Instantiation
      production = options[:I_HAVE_BEEN_TOLD_OF_THE_RISKS_AND_UNDERSTAND_RUNNING_THIS_IN_PRODUCTION_IS_SUPER_DUMB] || false
      children = options[:children]&.to_i || 1
      exclusions = options[:exclusions]&.split(",") || []
      
      # Production runs are ill-advised but supported anyways.
      if Rails.env.production? && (production.to_s != "true")
        puts "Running this in production is not advised. However, instructions have been provided below for people crazy enough to try it. Good luck."
        puts "ActiveScratcher::Scratch.execute(I_HAVE_BEEN_TOLD_OF_THE_RISKS_AND_UNDERSTAND_RUNNING_THIS_IN_PRODUCTION_IS_SUPER_DUMB: true#{(", children: #{children}") if children.to_i > 1}#{(", exclusions: #{exclusions}") if exclusions.length > 0})"
        return
      end
      
      # Need ActiveRecord classes loaded into memory
      puts "Eager Loading your Rails App"
      Rails.application.eager_load!
      
      puts "\nParameters List Below"
      puts "Exclusion List: #{exclusions}"
      puts "Expected Children Count: #{children}"
      # Print out if you're in Production mode
      puts "Production Mode: #{Rails.env.production?}, ProductionOverride: #{production}" if production && Rails.env.production?
      puts "\nExecuting ActiveScratcher"
      
      # Enumerate the ActiveRecord objects 
      active_objects = []
      if defined?(ApplicationRecord)
        puts "\nFound ApplicationRecord class"
        active_objects = ApplicationRecord.descendants
        @supported_db_types = ApplicationRecord.connection.native_database_types.keys
      elsif defined?(ActiveRecord::Base)
        puts "\nDid not find ApplicationRecord class. This may be okay, but... "
        puts "You should still be inheriting from ApplicationRecord on Rails 5.0+ (Source: http://blog.bigbinary.com/2015/12/28/application-record-in-rails-5.html)"
        active_objects = ActiveRecord::Base.descendants
        @supported_db_types = ActiveRecord::Base.connection.native_database_types.keys
      end
      
      # Verify what we received
      if active_objects.length <= 0
        # Make sure we tell the user we didn't find anything.
        puts "\nFound no ActiveRecord classes."
        puts "If you think this is an error, you may open a Github issue."
      else
        # Tell the user what we found
        puts "\nFound the following ActiveRecord classes."
        puts active_objects.map {|f| puts "Class: #{f}#{'(EXCLUDED CLASS)' if exclusions.include?(f)}"}
        
        # 
        puts "\n%%%%%%%%%%% BEGINNING DATABASE WORK %%%%"
        active_objects.each do |object|
          if !exclusions.include?(object)
            create_reqs(table: object, child: children)
          end
        end
        puts "%%%%%%%%%%% ENDING DATABASE WORK %%%%"
      end
      
      true
    end
    
    private
      def create_reqs(options={})
        target_table = options[:table] || puts "Skipping missing table"; return
        target_children = options[:children] || 1
        
        puts "Modifying table #{target_table}. Adding #{target_children} dependencies"
      end
  end
end
