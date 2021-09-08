class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /todays_stats
  def get_todays_stats
    @event_types = Event.find_by_sql("
      SELECT
        event_type, count(1) cnt
      FROM events
      WHERE created_at::date = current_date
        and char_length(event_type) >= 1
      GROUP BY event_type
      ORDER BY cnt DESCgit init
    ")
    
    todays_stats = []
    @event_types.each do |e|
      # todays_statse.event_type => e.cnt
      todays_stats.push({
        e.event_type => e.cnt
      })
    end 

    render json: {"todays_stats": todays_stats}
  end 

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    print(@event)


    if @event.save
      render json: @event, status: :created, location: @event
    else
      msg = "Required field " 
      if @event.name.nil? ^ @event.event_type.nil? # one is missing
        msg = @event.name.nil? ? "'name'" : "'event_type'"
        msg += " is missing"
      elsif # both are missing 
        msg = "Required fields 'name' and 'event_type' are missing"
      else
        msg = "Invalid input"
      end
      render json: msg, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_params
      params.require(:event).permit(:name, :event_type)
    end
end
