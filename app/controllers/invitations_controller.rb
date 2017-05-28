class InvitationsController < ApplicationController
  before_action :set_meeting
  before_action :set_meeting_invitation, only: [:show, :update, :destroy]

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
    @meeting.invitations.create!(invitation_params)
    json_response(@meeting, :created)
  end

  # PUT /meetings/:meeting_id/invitations/:id
  def update
    @invitation.update(invitation_params)
    head :no_content
  end

  # DELETE /meetings/:meeting_id/invitations/:id
  def destroy
    @invitation.destroy
    head :no_content
  end

  private

  def invitation_params
    params.permit(:name, :done)
  end

  def set_meeting
    @meeting = meeting.find(params[:meeting_id])
  end

  def set_meeting_invitation
    @invitation = @meeting.invitations.find_by!(id: params[:id]) if @meeting
  end
end
