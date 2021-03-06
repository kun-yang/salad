require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "projects/import_feature.html.erb" do
  before(:each) do
    @project = mock_model(Project)
  end
  context "features to import" do

    context "no features to import" do
      before(:each) do
        assigns[:project] = @project
        render
      end
      it "should not display a list of feature files to import" do
        response.should_not have_selector :ul, attribute = {:id => 'import_list'}
      end
    end

    context "new features to import" do
      before(:each) do
        assigns[:project] = @project
        assigns[:to_import] = [FeatureFile.new("#{RAILS_ROOT}/features/plain/tag_cloud.feature").export]
        render
      end

      it "has a list of feature files to import" do
        response.should have_selector :ul, attribute = {:id => 'import_list'}
      end

      it "should have a link to import that feature" do
        response.should have_selector :a, :content => "Import #{File.basename(assigns[:to_import].first.path).sub('.feature', '').gsub('_',' ')}"
      end
    end
  end
end