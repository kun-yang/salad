module WelcomeHelper
  def display_features_message project
    message = 'which has no features'
    if project.features.count >= 1
      message = "with #{project.features.count} features"
    end
    message
  end
end
