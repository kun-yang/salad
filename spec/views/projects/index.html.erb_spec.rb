require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/projects/index.html.erb" do

  context "No projects stored" do
    before(:each) do
      Project.stub!(:find).and_return []
      render
    end
    
    it "should display a message telling the user no projects are available" do
      response.should have_selector :span, :content => "No projects available"
    end
  end
  
  context "Projects are stored on the system" do
    before(:each) do
      assigns[:projects] = Project.find :all
      render
    end
    
    it "should have a list of projects" do
      response.should have_selector :ul do |list|
        list.should have_selector :li do |content|
          content.should have_selector :div, :content => "A fixture project"
          content.should have_selector :div, :content => "A description for our project"
          content.should have_selector :div, :content => "A projects aims"
        end
      end
    end
  end
end