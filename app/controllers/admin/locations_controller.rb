class Admin::LocationsController < Admin::ForestController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @locations = apply_scopes(Location).by_id.page(params[:page])
  end

  def show
    authorize @location
  end

  def new
    @location = Location.new
    authorize @location
  end

  def edit
    authorize @location
  end

  def create
    @location = Location.new(location_params)
    authorize @location

    if @location.save
      redirect_to edit_admin_location_path(@location), notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @location

    if @location.update(location_params)
      redirect_to edit_admin_location_path(@location), notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @location
    @location.destroy
    redirect_to admin_locations_url, notice: 'Location was successfully destroyed.'
  end

  private

    def location_params
      # Add blockable params to the permitted attributes if this record is blockable `**BlockSlot.blockable_params`
      params.require(:location).permit(:slug, :title, :latitude, :longitude)
    end

    def set_location
      @location = Location.find(params[:id])
    end
end
