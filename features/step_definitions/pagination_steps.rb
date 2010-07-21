Given /^there are "([^\"]*)"$/ do |model|
  models = []
  3.times { models << model.capitalize.singularize.constantize.make }
  model.capitalize.singularize.constantize.stub!(:all).and_return models
  model.capitalize.singularize.constantize.all.should_not be_empty
end

Given /^there are less than 5 "([^\"]*)"$/ do |model|
  assert model.capitalize.singularize.constantize.all.count <= 5
end

Then /^we should not see our pagination$/ do
  response.should_not have_selector :div, attribute = {:class => "pagination"}
end