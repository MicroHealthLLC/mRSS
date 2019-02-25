class MeetingsController < ApplicationController
  before_action :set_room
  before_action :set_meeting, only: [:show, :edit, :update, :destroy]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new room_id: @room.id, time_end: params[:time_end], time_start: params[:time_start]
    @meeting.meeting_dates.build(date: params[:date])
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)
    params[:date].to_s.split(',').each do |md|
      @meeting.meeting_dates.build(date: md)
    end
    respond_to do |format|
      if @meeting.save
        format.js { render js: 'window.location.reload()' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.js {
        }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    @meeting.attributes = meeting_params
    @meeting.meeting_dates.delete_all
    dates = params[:date].to_s.split(',')
    @meeting.meeting_dates.where.not(date: dates).delete_all
    dates.each do |md|
      @meeting.meeting_dates.where(date: md).first_or_initialize
    end
    respond_to do |format|
      if @meeting.valid? and @meeting.save
        format.html { redirect_to @room, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
        format.js { render js: 'window.location.reload()' }
      else
        format.js {}
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to @room, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meeting
    @meeting = Meeting.find(params[:id])
  end

  def set_room
    @room = Room.find params[:room_id]
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meeting_params
    params.require(:meeting).permit(:name, :description, :room_id, :date, :time_start, :time_end)
  end
end
