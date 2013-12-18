require 'thor'

module Lazyman
  class CLI < Thor
    include Thor::Actions
    argument :name

    def self.source_root
      File.join File.dirname(__FILE__)
      #File.join File.dirname(__FILE__), 'generators'
    end

    def self.source_paths
      puts source_root
      [source_root + '/generators', source_root + '/templates']
    end
    
    desc 'new', 'create a lazyman project'
    def new
      if name
        directory 'lazyman', name
      else
        say 'no app name'
      end
    end

    desc 'go ', 'run test case with rspec'

    def go
      ARGV.shift
      puts "rspec #{ARGV.join('')}" if $debug
      run "rspec #{ARGV.join('')}"
    end

    desc 'c ', 'open lazyman console'

    def c
      run 'bin/console'
    end

    desc "new_spec", "create a new spec and page"
    method_option :type,
      :default => "browser",
      :aliases => "-t",
      :desc => "which type of template to create [browser,webService,plain]."

    def new_spec
      case options["type"].downcase
      when "browser"
        template('browser_spec_template.rb.tt', "#{name}_spec.rb")
      when "webservice"
        template('web_service_template.rb.tt', "#{name}_spec.rb")
      when "plain"
        template('plain_template.rb.tt', "#{name}_spec.rb")
      when "mobile"
        template('mobile_template.rb.tt', "#{name}_spec.rb")
      else
        template('browser_spec_template.rb.tt', "#{name}_spec.rb")
      end
    end
  end #CLI
  CLI.start
end #Lazyman

