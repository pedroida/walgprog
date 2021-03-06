RSpec::Matchers.define :have_flash do |type, options|
  match do |page|
    page.has_selector?("div.alert.alert-#{type}", text: options[:text])
  end
  failure_message do
    "expected that page have #{type} flash message with '#{options[:text]}'"
  end
end
