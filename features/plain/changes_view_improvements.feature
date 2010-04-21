Feature: Changes view improvements
    In order help me know what has changed
    As a user
    I want to be given more information

    Scenario Outline: Each sync and change view should have a legend of what has change
      Given there is a feature
      And the feature has a path
      When the feature has changed "Something different"
      And I view the feature
      And I use the "<link>" link
      Then changes on the "<system_or_file>" should be displayed as "<colour>"

    Examples: Legend views
      | link          | system_or_file        | colour |
      | merge changes | Removing from file    | red    |
      | merge changes | Adding to file        | green  |
      | merge system  | Adding to system      | green  |
      | merge system  | Removing from system  | red    |
      | view changes  | Changes to the system | green  |
      | view changes  | Changes to the file   | red    |