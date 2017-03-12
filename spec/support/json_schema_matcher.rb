JSON_SCHEMAS_DIR = Rails.root.join('spec/support/json_schemas')

RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_path = JSON_SCHEMAS_DIR.join("#{schema}.json").to_s
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
