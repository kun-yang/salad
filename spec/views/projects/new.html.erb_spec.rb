require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/new.html.erb" do
  before(:each) do 
    @features = Feature.find :all
    assigns[:features] = @features
    assigns[:project] = Project.new
    render
  end
  it "should display a form" do
    response.should have_selector :form, attribute = {:action => projects_path}
  end
  
  describe "new project form" do
    
    it "should have a title" do
      response.should have_tag("form[action=#{projects_path}][method=post]") do
        with_tag('input#project_title[name=?]', "project[title]")
        with_tag('textarea#project_description[name=?]', "project[description]")
        with_tag('textarea#project_aim[name=?]', "project[aim]")
        with_tag('input#project_submit[name=?]', "commit")
      end
    end
    
    it "should have a list of checkboxes for each project that is avaiable" do
      response.should have_selector :form do |content|
        @features.each do |feature|
          content.should have_selector :input, attribute = {:type => "checkbox", :value => "#{feature.id}"}
        end
      end
    end
  end
  
end