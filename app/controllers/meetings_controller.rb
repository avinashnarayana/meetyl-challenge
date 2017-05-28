class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :update, :destroy]

  # GET /meetings
  def index
    @meetings = meeting.all
    json_response(@meetings)
  end

  # POST /meetings
  def create
    @meeting = meeting.create!(meeting_params)
    json_response(@meeting, :created)
  end

  # GET /meetings/:id
  def show
    json_response(@meeting)
  end

  # PUT /meetings/:id
  def update
    @meeting.update(meeting_params)
    head :no_content
  end

  # DELETE /meetings/:id
  def destroy
    @meeting.destroy
    head :no_content
  end

  private

  def meeting_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_meeting
    @meeting = meeting.find(params[:id])
  end
end
