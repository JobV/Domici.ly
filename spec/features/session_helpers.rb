module SessionHelpers
  # def sign_up_with(email, password)
  #   visit sign_up_path
  #   fill_in 'Email', with: email
  #   fill_in 'Password', with: password
  #   click_button 'Sign up'
  # end

  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_email',    with: user.email
    fill_in 'user_password', with: user.password
    click_on 'Log in'
  end
end
