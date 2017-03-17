class SightingsController < ApplicationController
  before_action :set_sighting, only: [:show, :edit, :update, :destroy]

  # GET /sightings
  # GET /sightings.json
  def index
    # This is the logic for filtering sightings by date range
    if params[:start_date].blank? && params[:end_date].blank? && params[:filter_region].blank?
      @sightings = Sighting.all
    elsif !params[:start_date].blank? && !params[:end_date].blank? && params[:filter_region].blank?
      @sightings = Sighting.where(date: params[:start_date]..params[:end_date])
      render('sightings/index.html.erb')
    elsif params[:start_date].blank? && params[:end_date].blank? && !params[:filter_region].blank?
      @sightings = Sighting.where(region: params[:filter_region])
      render('sightings/index.html.erb')
    elsif !params[:start_date].blank? && !params[:end_date].blank? && !params[:filter_region].blank?
      @sightings = Sighting.where(date: params[:start_date]..params[:end_date], region: params[:filter_region])
      render('sightings/index.html.erb')
    elsif !params[:start_date].blank? && params[:end_date].blank? && params[:filter_region].blank?
      @sightings = Sighting.where(date: params[:start_date]..'3000-01-01')
      render('sightings/index.html.erb')
    elsif params[:start_date].blank? && !params[:end_date].blank? && params[:filter_region].blank?
      @sightings = Sighting.where(date: '1000-01-01'..params[:end_date])
      render('sightings/index.html.erb')
    elsif !params[:start_date].blank? && params[:end_date].blank? && !params[:filter_region].blank?
      @sightings = Sighting.where(date: params[:start_date]..'3000-01-01', region: params[:filter_region])
      render('sightings/index.html.erb')
    elsif params[:start_date].blank? && !params[:end_date].blank? && !params[:filter_region].blank?
      @sightings = Sighting.where(date: '1000-01-01'..params[:end_date], region: params[:filter_region])
      render('sightings/index.html.erb')
    end
  end

  # GET /sightings/1
  # GET /sightings/1.json
  def show
  end

  # GET /sightings/new
  def new
    @sighting = Sighting.new
      #Setup the animals list
      if params[:animal].nil?
        # assign a default Animal if the params are empty
        @sighting.animal = Animal.first
      else
        #use Animal in the URL param and tell the new Sighting that it belongs to this Animal
        @sighting.animal = Animal.find(params[:animal])
      end
    # Setup the animal dropdown list
    @animals_for_select = Animal.all.map do |animal|
      [animal.common_name, animal.id]
    end
  end

  # GET /sightings/1/edit
  def edit
    @animals_for_select = Animal.all.map do |animal|
      [animal.common_name, animal.id]
    end
  end

  # POST /sightings
  # POST /sightings.json
  def create
    @sighting = Sighting.new(sighting_params)
    @animals_for_select = Animal.all.map do |animal|
      [animal.common_name, animal.id]
    end
    respond_to do |format|
      if @sighting.save
        format.html { redirect_to @sighting, notice: 'Sighting was successfully created.' }
        format.json { render :show, status: :created, location: @sighting }
      else
        format.html { render :new }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sightings/1
  # PATCH/PUT /sightings/1.json
  def update
    respond_to do |format|
      if @sighting.update(sighting_params)
        format.html { redirect_to @sighting, notice: 'Sighting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sighting }
      else
        format.html { render :edit }
        format.json { render json: @sighting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sightings/1
  # DELETE /sightings/1.json
  def destroy
    @sighting.destroy
    respond_to do |format|
      format.html { redirect_to sightings_url, notice: 'Sighting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_events
    @sightings = Sighting.all
    events = []
    @sightings.each do |sighting|
      events << { id: sighting.id, title: sighting.animal.common_name, start: sighting.date, url: Rails.application.routes.url_helpers.sighting_path(sighting.id)}
    end
    render :json => events.to_json
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sighting
      @sighting = Sighting.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def sighting_params
      params.require(:sighting).permit(:date, :time, :latitude, :longitude, :region, :animal_id, :start_date, :end_date, :filter_region)
    end
end
