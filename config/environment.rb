# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Amazon::Ecs.options = {
      associate_tag:     'kumamoncom-22',
      AWS_access_key_id: 'AKIAIOVCDWAARTIXPV4Q',
      AWS_secret_key:   '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'
}
