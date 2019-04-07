class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # allow to see all groups without authentication
  skip_before_action :authenticate_user!, only: [:show, :index]
  # GET /groups
  # GET /groups.json
  def index
    if request.headers.include? "uid"
      @groups = User.where(uid: request.headers["uid"]).first.groups
      # puts "USER! #{request.headers["uid"].inspect}"
    else
      @groups = Group.all
      # puts "USER! #{request.headers["uid"].inspect}"
    end
    @groups.each { |x| update_attributes(s3: x.featured_image.service_url) if x.featured_image.attached? }
    render json: @groups, include: ['categories']
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    render json: @group, include: ['categories']
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.update_attributes(user: current_user)

    information = request.body.read
    data_parsed = JSON.parse(information)
    if data_parsed['categories'] 
      categories = data_parsed['categories']
    end
    puts "here: #{categories}"
    # content = JSON.parse(request.body.read.force_encoding("UTF-8"))

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        
        if categories
          categories.each do |category|
            Category.create(name: category, group_id: Group.last.id)
          end
        end
        format.json { render json: @group, include: ['categories'] }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

  
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.permit(:name, :description, :featured_image, :categories => [])
    end
end

