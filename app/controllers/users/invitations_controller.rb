class Users::InvitationsController < Devise::InvitationsController

  def new
    self.resource = User.new
    render :new
  end

  # POST /resource/invitation
  def create
    role = params[:role]
    emails = params[:emails].split("\n")

    # Make this async
    emails.each do |e|
      user = User.invite!(email: e, hoa: current_inviter.hoa)
      user.add_role role, user.hoa
    end

    redirect_to organisation_path, notice: 'Uitnodiging(en) verzonden.'

    # TODO Handle errors better
    # if resource.errors.empty?
    #   set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
    #   yield resource if block_given?
    #   respond_with resource, :location => after_invite_path_for(resource)
    # else
    #   respond_with_navigational(resource) { render :new }
    # end

  end

  # GET /resource/invitation/accept?invitation_token=abcdef
  def edit
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  # PUT /resource/invitation
  def update
    self.resource = accept_resource

    if resource.errors.empty?
      yield resource if block_given?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active                                                                                        
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      respond_with resource, :location => after_accept_path_for(resource)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end
  
  # GET /resource/invitation/remove?invitation_token=abcdef
  def destroy
    resource.destroy
    set_flash_message :notice, :invitation_removed
    redirect_to after_sign_out_path_for(resource_name)
  end

  protected

  def invite_resource(&block)
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.hoa = current_inviter.hoa
    end
  end
  
  def accept_resource
    resource_class.accept_invitation!(update_resource_params)
  end

  def current_inviter
    @current_inviter ||= authenticate_inviter!
  end

  def has_invitations_left?
    unless current_inviter.nil? || current_inviter.has_invitations_left?
      self.resource = resource_class.new
      set_flash_message :alert, :no_invitations_remaining
      respond_with_navigational(resource) { render :new }
    end
  end
  
  def resource_from_invitation_token
    unless params[:invitation_token] && self.resource = resource_class.find_by_invitation_token(params[:invitation_token], true)
      set_flash_message(:alert, :invitation_token_invalid)
      redirect_to after_sign_out_path_for(resource_name)
    end
  end

  def invite_params
    devise_parameter_sanitizer.sanitize(:invite)
  end

  def update_resource_params
    devise_parameter_sanitizer.sanitize(:accept_invitation)
  end

  private
   def resource_params
     params.permit(user: [:name, :email, :emails, :invitation_token, :hoa, :role])[:user]
   end
end
