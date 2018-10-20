# frozen_string_literal: true

require 'simplecov'
require 'webmock/rspec'

SimpleCov.start

require_relative '../../lib/environment'

Dir["#{Environment::APP_ROOT}/spec/support/**/*.rb"].each { |f| require f }

WebMock.disable_net_connect!(allow_localhost: true, allow: ['api.codacy.com', 'codeclimate.com'])
