RSpec::Matchers.define :be_http_200 do
  match { actual.status == 200 }
end
