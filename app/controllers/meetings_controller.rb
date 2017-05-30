class MeetingsController < ApplicationController
  before_action :set_meeting_for_inviter, only: [:update, :destroy]
  before_action :set_meeting, only: :show
  # GET /meetings gives created and invited meetings
  def index
    @meetings = (current_user.meetings + current_user.invited_meetings).sort_by(&:start_time)
    json_response(@meetings)
  end

  # POST /meetings
  def create
    @meeting = current_user.meetings.create!(meeting_params)
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
    params.permit(:subject, :inviter_id, :location, :start_time, :end_time, :max_size)
  end

  def set_meeting
    @meeting = Meeting.find(params[:id])
  end
  
  def set_meeting_for_inviter
    @meeting = current_user.meetings.find_by!(id: params[:id])
  end
end
