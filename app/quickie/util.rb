class Util

	def self.github_name
		`git config --get user.name`.chomp
	end

	def self.github_email
		`git config --get user.email`.chomp
	end

	def self.github_user
		`git config --get github.user`.chomp
	end

end