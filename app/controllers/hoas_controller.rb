class HoasController < ApplicationController
  before_action :set_hoa, only: [:show, :edit, :update, :destroy]

  # GET /hoas
  def index
    @hoas = Hoa.all
  end

  # GET /hoas/1
  def show
  end

  # GET /hoas/new
  def new
    @hoa = Hoa.new
  end

  # GET /hoas/1/edit
  def edit
  end

  # POST /hoas
  def create
    @hoa = Hoa.new(hoa_params)

    if @hoa.save
      redirect_to @hoa, notice: 'Hoa was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /hoas/1
  def update
    if @hoa.update(hoa_params)
      redirect_to @hoa, notice: 'Hoa was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /hoas/1
  def destroy
    @hoa.destroy
    redirect_to hoas_url, notice: 'Hoa was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hoa
      @hoa = Hoa.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def hoa_params
      params.require(:hoa).permit(:name)
    end
end
