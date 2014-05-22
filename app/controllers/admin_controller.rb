class AdminController < ApplicationController
  def change_hoa
    if current_user.admin
      hoa = Hoa.find(params[:id])
      current_user.hoa = hoa
      current_user.save
      current_user.add_role :moderator, hoa
      redirect_to organisation_url(subdomain: hoa.subdomain_name)
    else
      redirect_to organisation_path
    end
  end
end
