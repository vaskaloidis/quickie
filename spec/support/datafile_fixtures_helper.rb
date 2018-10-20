# frozen_string_literal: true

def load_fixture_text(file_name)
  File.open([Environment::APP_ROOT, 'spec', 'support', 'fixtures', file_name].join('/'), &:read)
end
