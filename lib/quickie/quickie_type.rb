module Quickie
  module QuickieType
    include Thor::Actions
    include Util
    attr_accessor :new_app, :template_file

    def self.extended(klass)
      name = @template_file
      @new_app = name
      puts "Quickie Template Name: #{name}"
      build_template
      # setup
      destination_root = Dir.home
    end

    def build_template
      if app_template.end_with? '.tt'
        puts "Template Name: #{app_template}"
        puts "New App Name: #{new_app}"
        template(app_template, "./#{new_app}")
      else
        copy_file app_template, "./#{new_app}"
      end
    end

    def starters(starter_files, target: new_app)
      if starter_files.is_a? String
        puts "Starter File: #{starter_files}"
        append_starter target, starter_files
      elsif starter_files.is_a? Array
        puts "Starter File: #{starter_files.map {|f| f}}"

        starter_files.map {|file| append_starter target, file}
      end
    end

    def template_name
      base = (app_template.end_with?(".tt") ? remove_extension(app_template) : app_template)
      remove_extension base
    end

    def app_template
      "./lib/quickie/templates/#{template_dir}/#{base_template}"
    end

    # ./templates/<template_dir>/
    def template_dir
      raise 'You must specify a template_dir IE: lib/quickie/templates/<template_dir>/'
    end

    # ./templates/<template_dir>/<base_template>
    def base_template
      raise 'You must specify a template_location IE: lib/quickie/templates/<template_dir>/<base_template/ | base_template>.ext> '
    end

    private

    def append_starter(target, starter)
      append_to_file target do
        apply starter
      end
    end

  end
end