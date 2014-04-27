class HomepagesController < ApplicationController
  before_action :set_homepage, only: [:destroy]
  before_action :set_homepage_by_subdomain, only: [:show, :edit, :update]
  before_filter :authenticate_user!, except: [:show]

  # GET /homepages
  def index
    @homepages = Homepage.all
  end

  # GET /homepages/1
  def show
    # TODO Replace by call to @homepage.title
    # @title = @homepage.hoa.name
  end

  # GET /homepages/new
  def new
    @homepage = Homepage.new
  end

  # GET /homepages/1/edit
  def edit
  end

  # POST /homepages
  def create
    @homepage = Homepage.new(homepage_params)

    if @homepage.save
      redirect_to @homepage, notice: 'Homepage was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /homepages/1
  def update
    if @homepage.update(homepage_params)
      redirect_to @homepage, notice: 'Homepage was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /homepages/1
  def destroy
    @homepage.destroy
    redirect_to homepages_url, notice: 'Homepage was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homepage
      @homepage = Homepage.find(params[:id])
    end

    def set_homepage_by_subdomain
      @homepage = Homepage.find_by(subdomain_name:request.subdomain)
    end

    # Only allow a trusted parameter "white list" through.
    def homepage_params
      params[:homepage]
    end
end
