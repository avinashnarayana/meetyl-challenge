class InvitationsController < ApplicationController
  before_action :set_meeting, only: [:index, :show, :update]
  before_action :set_meeting_for_inviter, only: [:create, :destroy]
  before_action :set_meeting_invitation, only: [:show, :update, :destroy]
  before_action :set_invitee, only: :create
  # GET /meetings/:meeting_id/invitations
  def index
    json_response(@meeting.invitations)
  end

  # GET /meetings/:meeting_id/invitations/:id
  def show
    json_response(@invitation)
  end

  # POST /meetings/:meeting_id/invitations
  def create
    @invitation = @meeting.invitations.create!(invitee_id: @invitee.id)
    json_response(@invitation, :created)
  end

  # PUT /meetings/:meeting_id/invitations/:id
  # Ensuring that only one invitee can update their response at a time
  def update
    ActiveRecord::Base.transaction do
      @invitee = @invitation.invitee
      accepted_invitees = @meeting.invitations.count { |invitation| invitation.response == "Accepted"}
      if @invitee==current_user && @meeting.max_size>= accepted_invitees
        if @invitation.update_attributes(invitation_update_params)
          return json_response(@invitation, :updated)
        end
      end
    end
    head :no_content
  end

  # DELETE /meetings/:meeting_id/invitations/:id
  def destroy
    @invitation.destroy
    head :no_content
  end

  private

  def set_invitee
    if params.has_key?(:email)
      @invitee = User.find_by!(email: params[:email])
    else
      @invitee = User.find_by!(id: params[:invitee_id])
    end
  end
  
  def invitation_update_params
    params.permit(:response)
  end

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
  end

  def set_meeting_invitation
    @invitation = @meeting.invitations.find_by!(id: params[:id]) if @meeting
  end

  def set_meeting_for_inviter
    @meeting = current_user.meetings.find_by!(id: params[:meeting_id])
  end
end
