# frozen_string_literal: true

require 'spec_helper'

describe Quickie, type: :generator do
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(bash-quick)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'generates a simple BASH folder and script' do
   
  end
  

end
