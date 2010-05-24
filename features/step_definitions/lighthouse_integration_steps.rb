Given /^we are using the account name "([^\"]*)"$/ do |account_name|
  Lighthouse.account = account_name
end

Given /^we have an the project number "([^\"]*)"$/ do |project_number|
  @project_number = project_number
end

Given /^I visit the parking page$/ do
  visit parking_index_path
end

Given /^we visit the new parking page$/ do
  visit new_parking_path
end

Given /^we have set up the lighthouse resource$/ do
  Given %{we visit the new parking page}
  When %{I fill in "resource_name" with "baphled"}
  And %{I fill in "resource_project_id" with "50164"}
  Then %{submit the form}
end

Given /^there are parked tickets on the system$/ do
  LightHouse.stub!(:all).and_return [mock_model(Lighthouse).as_null_object]
end

Given /^we have a tickets that is invalid$/ do
  LightHouse.stub!(:create).and_return false
end

When /^we specify the ticket type "([^\"]*)"$/ do |ticket_parameters|
  @lighthouse_tickets = Lighthouse::Ticket.find(:all, :params => { :project_id => @project_number, :q => "state:open tagged:feature" })
end

When /^we retrieve tickets$/ do
  @lighthouse_tickets.should_not be_empty
end

When /^I select "([^\"]*)"$/ do |selection|
  select selection
end

Then /^each of the features should be using the "([^\"]*)" tag$/ do |tag|
  @lighthouse_tickets.each {|ticket| ticket.tag.should contain 'feature'}
end

Then /^I should be sent to the "([^\"]*)" page$/ do |page_title|
  response.should contain page_title
end

Then /^the resource information should be saved$/ do
  Resource.find_by_name("baphled").should_not be_nil
end

When /^there should be a list of tickets found$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li
  end
end

Then /^I should be able to select tickets to add to parking$/ do
  response.should have_selector :ul do |list|
    list.should have_selector :li do |item|
      item.should have_selector :input, attribute = {:type => "checkbox"}
    end
  end
end

Then /^one item should be saved as parked items$/ do
  LightHouse.first.ticket_id.should_not eql 9
end

Then /^a list of parked ticket should be displayed$/ do
  response.should have_selector :ul, attribute  = {:id => "resource_list"} do |list|
    list.should have_selector :li
  end
end
