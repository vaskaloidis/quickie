module Quickie
	class Boilr

		def initialize

		end

		def self.installed?
			File.exists? '/usr/local/boilr'
		end

		def self.install!
			templates.each do |id, template|
				`boilr template download #{template}`
			end
		end

		def template(name, project_dir = File.pwd)
			parts = templates.get(name).split(' ')
			repo = parts.first
			id = parts.second
			` boilr template use #{id} #{project_dir}`
		end

		def templates
			{'apache-spark-app': 'tmrts/boilr-spark sparkapp',
				'dockr-compose-php', 'rawkode/boilr-docker-compose-php dcphp',
				'docker-vagrant', 'dmstr/vado-ligure vado'
				'electron': 'tmrts/boilr-electron electron',
				'python-package': ' aluriak/boilr-python python'}
		end

	end
end