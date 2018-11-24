require 'quickie'

module Quickie
	class Bash < Main
		extend QuickieType

		def initialize(template_file)
			@template_file = render template: ''
		end

		def template_dir
			'bash'
		end

		def base_template
			'bash.sh.tt'
		end

		def generate(&block)
			# copy_file("./templates/#{template_dir}/#{base_template}", "#{name}")
			yield
		end
	end
end