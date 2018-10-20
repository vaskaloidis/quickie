# frozen_string_literal: true

RSpec.describe Main do

  context 'generates a ruby file' do

    before :example do
      stub_request(:get, 'https://api.github.com/orgs/octokit/repos').
        to_return(status: 200, body: load_fixture_text('repos.json'))
    end

    subject do
      Main.new('octokit.py').run
    end

    it { is_expected.not_to be_nil }
  end

  it 'generates a ruby app' do
    
  end
  

end
