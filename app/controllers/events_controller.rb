class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(Hash["name" => event_params['name'], "user_id" => current_user.id])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @event = Event.find(params[:id])
    @event.invites.each do |invite|
      ExampleMailer.sample_email(invite).deliver_later
    end
    flash[:notice] = 'Evento confirmado, mails preparados'
    redirect_to event_path(@event)
  end

  # GET /events/1/guests/new
  def new_guest
    @event = Event.find(params[:event_id])
  end

  # POST /events/1/guests
  def create_guest
    @event = Event.find(params[:event_id])
    @invite = @event.invites.create(Hash[
      "name" => guest_params['name'],
      "mail" => guest_params['mail'],
      "invite_type" => 'guest',
      "confirmed" => 1,
      "receive_emails" => false
    ])
    send_update_emails(@event)
    flash[:notice] = "Guest #{ guest_params['name'] } agregado!"
    redirect_to event_path(@event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :user_id)
    end

    def guest_params
      params.require(:guest).permit(:name, :mail)
    end

    def send_update_emails(event)
      event.invites.where(receive_emails: true).each do |invite|
        ConfirmedMailer.sample_email(invite).deliver_later
      end
    end
end
