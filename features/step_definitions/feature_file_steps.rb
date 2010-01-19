Given /^we create a FeatureFile from a none cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/projects.yml")
end

Given /^we create a FeatureFile from a cucumber feature file$/ do
  @file = FeatureFile.new("#{RAILS_ROOT}/spec/fixtures/test.feature")
end


Then /^the object should be valid$/ do
  @file.should_not be_invalid
end

Then /^the feature property should not be nil$/ do
  @file.feature.should_not be_nil
end

Then /^the object should be invalid$/ do
  @file.should be_invalid
end

Then /^the 'In order' property should not be nil$/ do
  @file.in_order.should_not be_nil
end

Then /^the 'I want' property should not be nil$/ do
  @file.i_want.should_not be_nil
end

Then /^the object should have 1 or more scenarios$/ do
  @file.scenarios.should_not be_nil
end

