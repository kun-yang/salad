Feature: We want to be able to deal with Cucumber changing formats easily
    In order to improve the way our features files are imported
    As part of the system
    I want to be able to use cucumbers functionality to read our feature files

    Scenario: We should be able to parse a feature file using Cucumbers exising functionality
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then our parse FeatureFile should be called

    Scenario: We should be able to extract a scenario outline
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then a scenario outline should be found

    Scenario: We should be able to extract a scenarios examples
      Given we have a feature file
      And the feature file can be opened with Cucumbers FeatureFile object
      When we parse a file
      Then a scenario outline should be found
      And the scenario outlines example should be found

    Scenario: We need a way to get Scenario Outlines
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      Then each scenario outline should have the expected steps

    Scenario: We should not have the Scenario Outline as a prefix
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      And each scenario should not be prefixed with 'Scenario Outline:'

    Scenario: When a we have a scenario outline we also want to parse its examples
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      Then each scenario outline should have the expected steps
      And the scenario outline should precede its examples

    Scenario: When saving a scenario outlines examples we want to associate the example heading with the associated actions
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      And the scenario outline should precede its examples
      Then the example should have a list of actions
    
    Scenario: The associated actions should be seperated and not in the format they are in within cucumber
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      And the scenario outline should precede its examples
      Then the example should have a list of actions
      And the actions should only contain "items,action,state"

    Scenario Outline: All actions should be correctly associated to each of their items
      Given we create a FeatureFile from a cucumber feature file with a scenario outline
      When a feature is valid
      And it has a scenario outline
      And the scenario outline should precede its examples
      Then the example should have a list of actions
      And the actions should only contain "items,action,state"
      And the "<action>" should have "<item>" associated to it "<amount>" of times

    Examples: Actions and the number of times an action item should be stored
      |action |item       |amount |
      |items  |features   |4      |
      |items  |stories    |3      |
      |items  |steps      |2      |
      |action |features   |2      |
      |action |stories    |4      |
      |action |steps      |3      |
      |state  |being      |4      |
      |state  |not being  |5      |