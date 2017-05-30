class InvitationsController < ApplicationController
  before_action :set_meeting, except: [:create, :destroy]
  before action :set_invitation_for_invitee, only: :update
  before_action :set_meeting_invitation, only: :show
  before_action :set_meeting_for_inviter, only: [:create, :destroy]
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
    @invitation = @meeting.invitations.create!(invitation_create_params)
    json_response(@invitation, :created)
  end

  # PUT /meetings/:meeting_id/invitations/:id
  def update
    @invitation.update(invitation_update_params)
    head :no_content
  end

  # DELETE /meetings/:meeting_id/invitations/:id
  def destroy
    @invitation.destroy
    head :no_content
  end

  private

  def invitation_create_params
    params.permit(:invitee_id)
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
  
  # To ensure only invitee updates an invitation
  def set_invitation_for_invitee
    @invitation = current_user.invitations.find_by!(id: params[:id])
  end
  
  def set_meeting_for_inviter
    @meeting = current_user.meetings.find_by!(id: params[:meeting_id])
  end
end
