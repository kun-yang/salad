class Resource < ActiveRecord::Base
  validates_presence_of     :name
  validates_presence_of     :project

  validate :valid_lighthouse_account?, :if => :name_not_empty?
  validate :valid_lighthouse_project?, :if => :project_id_not_empty?

  def tickets(tag)
    Lighthouse.account = name
    Lighthouse::Ticket.find(:all, :params => { :project_id => project, :q => "state:open tagged:#{tag}" })
  end
  
  def ticket(number)
    Lighthouse.account = self.name
    Lighthouse::Ticket.find(number, :params => { :project_id => project})
  end

  def valid_lighthouse_account?
    begin
      Lighthouse.account = self.name
      Lighthouse::Project.find :all
    rescue ActiveResource::UnauthorizedAccess
      errors.add(:name, "must be a valid LightHouse project name")
    end
  end

  def valid_lighthouse_project?
    begin
      Lighthouse.account = self.name
      Lighthouse::Project.find self.project
    rescue ActiveResource::ResourceNotFound
      errors.add(:project, "must be a valid LightHouse project")
    end
  end
  
  private
    def name_not_empty?
      (self.name == '')? false : true
    end

    def project_id_not_empty?
      (self.project  == '' or self.name == '')? false : true
    end
end