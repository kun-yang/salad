Given /^I can view the (.*) page$/ do |controller|
  visit "/#{controller}"
end

Given /^there is a project$/ do
  @project = Project.new(:title=>"A project",
              :description=>"This is a description",
              :aim=>"the aim of our project is...")
  @project.save
end

Given /^I visit its edit view$/ do
  visit("/projects/#{@project.id}/edit")
end

Given /^there are projects$/ do
  @projects = Project.find :all
end

When "I click (.*) (.*)" do |action,controller|
  visit "/#{controller}/#{action}"
end

When /^fill in the new project with no errors$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the project title$/ do
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the description$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^don't fill in the aim$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
end

When /^fill in the new project all details$/ do
  fill_in 'project_title', :with => 'A project'
  fill_in 'project_description', :with => 'This is a description'
  fill_in 'project_aim', :with => 'the aim of our project is...'
end

When /^the project already exists$/ do
  @project = Project.new(:title=>"A project",
              :description=>"This is a description",
              :aim=>"the aim of our project is...")
  @project.save
end

When /^it is viewed$/ do
  visit "/projects/#{@project.id}"
end

When /^we edit the 'A project' project$/ do
  @found_project = Project.find_by_title("A project")
end

When /^we edit the 'A description' project$/ do
  fill_in 'project_description', :with => 'A different description'
end

When /^we edit the 'An aim' project$/ do
  fill_in 'project_aim', :with => 'A different aim'
end

When /^the project is not able to update$/ do
  @project.stub!(:update_attributes).and_return false
end

When /^I visit the projects index page$/ do
  visit('/projects')
  assigns[:projects] = @projects
end
When /^we view the first projects features$/ do
  visit('/projects/1/features')
end

When /^I visit the first projects features$/ do
  visit('/projects/1/features')
end

When /^I create new a feature$/ do
  click_link 'Add feature'
end

When /^a project has no features$/ do
  assert Project.find(1).feature_ids.empty?
end

When /^I visit the project$/ do
  visit('/projects/2/features')
end

Given /^there are no projects$/ do
    @projects << []
end

Then /^submit the form$/ do
  click_button 'Submit'
end

Then /^the project information should be saved$/ do
  assert_response :success
end

Then "I should be redirected to the new $controller" do |controller|
  current_url.should_not eql "/#{controller}/new"
end

Then "a flash message '(.*)' should be displayed" do |message|
  flash.should contain "#{message}"
end

Then /^I should be redirected to the form$/ do
  response.should have_selector :form
end

Then /^a form error must be displayed$/ do
  response.should have_selector :div, attribute = {:class => "errorExplanation"}
end

Then /^the user should be told the must have a (.*)$/ do |value|
  response.should contain "#{value.capitalize} can't be blank"
end

Then /^the user should be told the project already exists$/ do
  response.should contain "Title has already been taken"
end

Then /^I should be able to view its details$/ do
  response.should have_selector(:p, :content =>"This is a description")
end

Then /^I should be able to edit its title$/ do
  fill_in 'project_title', :with => 'A different title'
end

Then /^project title 'A project' should now be 'A different title'$/ do
  response.should contain 'A different title'
end

Then /^project description 'A description' should now be 'A different description'$/ do
  response.should contain 'A different description'
end

Then /^project aim 'An aim' should now be 'A different aim'$/ do
  response.should contain 'A different aim'
end

Then /^the project should not be updated$/ do
  response.should have_selector :form
end

Then /^I should not view a list of projects$/ do
  response.should_not have_selector :ul do |list|
    list.should_not have_selector :li
  end
end

Then /^should see a message saying 'No projects available'$/ do
  response.should have_selector :span, :content => "No projects available"
end

Then /^I should have a checkable list of features$/ do
  Feature.find(:all).each do |story|
    response.should contain story.title
    response.should have_selector :input
  end
end

Then /^we must be able to select 1 feature$/ do
  check 'project_feature_ids_'
end

Then /^the project features page will be displayed$/ do
  response.should have_selector :ul do |list|
    Project.find(1).features.each do |feature|
      list.should have_selector :li do |content|
        content.should contain => feature.title
      end
    end
  end
end

Then /^a summary of the project should be displayed$/ do
  @project = Project.find 1
  response.should have_selector :fieldset, attribute = {:class=>"project_field"} do |project_field|
    project_field.should have_selector :div, attribute = {:class=>"project_info"} do |project_info|
      project_info.should have_selector :span, :content => @project.title
      project_info.should have_selector :span, :content => @project.description
      project_info.should have_selector :span, :content => @project.aim
    end
  end
end

Then /^I should be sent to the new feature page$/ do
  response.should have_selector :form
end

Then /^the project should already be selected$/ do
  response.should have_selector :input, atrribute = {:type=>"checkbox",:value=>"1",:id=>"project_id_1"}
end
