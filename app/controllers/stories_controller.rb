class StoriesController < ApplicationController
  navigation :stories
  
  before_filter :find_story, :except => [:index,:new,:create,:add_step,:sort,:tag, :tags, :validate]
  
  before_filter :find_storys_steps, :only => [ :show, :update, :steps]

  before_filter :find_tags
  
  def index
    @stories = Story.paginate(:page => params[:page],:per_page => 5)
    respond_to do |format|
      format.html
      format.js { render "index.rjs" }
    end
  end
  
  def create
    @story = Story.new(params[:story])
    respond_to do |format|
      if @story.save
        find_storys_steps
        flash[:notice] = "Story: #{@story.scenario}, was created"
        format.js { render "create.rjs" }
        format.html { redirect_to :stories }
      else
        format.js { render :action => "new" }
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
  
  def edit
    @steps = append_steps(params[:step_ids])
  end
  
  def new
    if not params[:feature_id].nil?
      @feature = Feature.find(params[:feature_id])
      @story = @feature.stories.new(:feature_ids => [params[:feature_id]])
    else
      @story = Story.new
    end
    @steps = append_steps(params[:step_ids])
  end
  
  def update
    params[:story][:feature_ids] ||= []
    scenario = @story.scenario
    respond_to do |format|
      if @story.update_attributes(params[:story])
        @story_steps = @story.steps.paginate(:page=> params[:page], :per_page => 10, :order=>"step_stories.position") unless @story.steps.nil?
        flash[:notice] = "Story: #{scenario} was updated"
        format.js { render "create.rjs" }
        format.html { redirect_to @story }
      else
        flash[:error] = "Story: #{scenario} was not created"
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to(stories_path) }
      format.xml  { head :ok }
    end
  end
  
  def steps
    respond_to do |format|
      format.html
      format.js { render "show.rjs" }
    end
  end
  
  def sort
    params[:story].each_with_index do |id, index|
      @story = Story.find id
      @story.feature_stories.update_all(['position=?', index+1])
    end
    render :nothing => true
  end
  
  def tag
    @stories = Story.find_tagged_with params[:tag]
    render :index
  end
  
  def add_step
    @steps = Step.search(params[:search_text])
    respond_to do |format|
      if params[:id].nil?
        format.html { redirect_to new_story_path(:step_ids=>@steps) }
      else
        @story = Story.find params[:id]
        format.html { redirect_to edit_story_path(:step_ids=>@steps) }
      end
    end
  end
  
  def validate
    result = true
    if Story.find_by_scenario params[:scenario]
        result = "Must be a unique story."
    end
    render :json => result.to_json
  end
  
  private
    def append_steps step_ids
      new_steps = []
      if step_ids
        step_ids.each do |step|
          new_steps << Step.find(step)
        end
      end
      if @story
        @story.steps.each do |step|
          new_steps << step
        end
      end
      new_steps
    end
  
    def find_storys_steps
      @story_steps = @story.steps.paginate(:page=> params[:page], :per_page => 10, :order=>"step_stories.position") unless @story.steps.nil?
    end

    def find_tags
      @tags = Story.tag_counts
    end
    
    def find_story
      @story = Story.find(params[:id])
    end
end