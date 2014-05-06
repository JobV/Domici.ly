class AdminController < ApplicationController
  def change_hoa
    if current_user.admin
      hoa = Hoa.find(params[:id])
      current_user.hoa = hoa
      current_user.save
      redirect_to dashboard_index_url(subdomain: hoa.subdomain_name)
    else
      redirect_to dashboard_index_path
    end
  end
end
