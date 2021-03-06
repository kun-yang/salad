require 'spec_helper'

describe "/welcome/index" do
  

  context "when there are no projects" do

    before(:each) do
      assigns[:project] = nil
      render 'welcome/index'
    end

    it "should display a message stating that there are no projects in Salad" do
      response.should have_tag('p', %r[There are no projects])
    end

    it "should display a link to the projects page" do
      response.should have_selector :div do |instructions|
        instructions.should contain 'add a project'
      end
    end

  end

  context "when there are projects" do

    before(:each) do
      @project = stub_model(Project,
                            :title => 'A project',
                            :creation_date => Time.now.to_s(:long)
                          ).as_new_record.as_null_object
      assigns[:project] = @project
    end

    context "with a single feature" do
      before(:each) do
        assigns[:project].stub(:features).and_return [mock_model(Feature).as_new_record]
        render 'welcome/index'
      end

      it "should display the last project" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should have_selector :b, :content => @project.title
        end
      end

      it "should display a message stating there is a single feature" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should contain "#{@project.features.count} feature"
        end
      end
    end
    
    context "with more than 1 feature" do
      before(:each) do
        @features = []
        3.times { |feature_number | @features << mock_model(Feature).as_new_record }
        assigns[:project].stub(:features).and_return @features
        render 'welcome/index'
      end

      it "should display a pluralised message for the amount of features the project has" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should contain "#{@project.features.count} features"
        end
      end
    end

    context "when the latest project has no features" do
      before(:each) do
        assigns[:project].stub(:features).and_return []
        render 'welcome/index'
      end

      it "should display a message stating that the project has no features" do
        response.should have_selector :div, attribute = {:id=>"latest_project"} do |project_info|
          project_info.should contain "which has no features"
        end
      end
    end
    
  end

end
