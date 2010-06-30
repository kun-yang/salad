module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /export feature/
      '/features/1/export'
    when /import project/
      '/projects/1/import'
    when /feature changes/
      '/features/1/changes'
    when /feature merge/
      '/features/1/merge'
    when /system merge/
      '/features/1/system_merge'
    when /new project/
      'projects/new'
    when /edit project/
      '/projects/1/edit'
    when /new feature/
      'features/new'
    when /edit feature/
      'features/1/edit'
    when /new story/
      'stories/new'
    when /edit story/
      'stories/1/edit'
    when /new step/
      'steps/new'
    when /edit step/
      'steps/1/edit'
     when /projects features/
       'projects/1/features'
     when /features stories/
       'features/1/stories'
     when /stories steps/ 
       'stories/1/steps'
    when /a project/
      '/projects/1'
    when /a feature/
      'features/1'
    when /a story/
      'stories/1'
    when /a step/
      'steps/1'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
