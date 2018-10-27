# frozen_string_literal: true

require 'spec_helper'


describe Quickie, "using custom matcher", type: :generator do
  destination File.expand_path("../../tmp", __FILE__)

  before do
    prepare_destination
    run_generator
  end

  specify do
    expect(destination_root).to have_structure {
      no_file "test.rb"
      directory "config" do
        directory "initializers" do
          file "test.rb" do
            contains "# Initializer"
          end
        end
      end
      directory "db" do
        directory "migrate" do
          file "123_create_tests.rb"
          migration "create_tests" do
            contains "class TestMigration"
          end
        end
      end
    }
  end
end
