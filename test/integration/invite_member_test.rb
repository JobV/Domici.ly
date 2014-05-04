require 'test_helper'

## Inviting a member to your Hoa
#
# 1. Only boardmembers can invite
# 2. The role should be set between user, moderator (boardmember) and 
# maintenance
#

class InviteMemberTest < ActionDispatch::IntegrationTest
  include RoleTestHelper

  def setup
    @hoa = create(:hoa)

    # Random user
    @home_owner = create(:user, hoa: @hoa, first_name: 'Job')

    # Maintenance person
    @maintenance = create(:user, hoa: @hoa, first_name: 'Piet')
    @maintenance.add_role :maintenance, @hoa

    # Board member
    @moderator = create(:user, hoa: @hoa, first_name: 'Steve')
    @moderator.add_role :moderator, @hoa
  end

  test 'home_owner can not invite anyone' do
    sign_in @home_owner
    click_on @hoa.name
    page_should_not_contain 'Nieuw Lid'
  end

  test 'maintenance can not invite anyone' do
    sign_in @maintenance
    click_on @hoa.name
    page_should_not_contain 'Nieuw Lid'
  end

  test 'moderator can invite a new home_owner' do
    add_member('home@example.com', 'role_user')
    assert_not_role User.last, :moderator, @hoa
    assert_not_role User.last, :maintenance, @hoa
  end

  test 'moderator can invite a new maintenance' do
    add_member('maintenance@example.com', 'role_maintenance')
    assert_not_role User.last, :moderator, @hoa
    assert_role User.last, :maintenance, @hoa
  end

  test 'moderator can invite a new moderator' do
    add_member('moderator@example.com', 'role_moderator')
    assert_role User.last, :moderator, @hoa
    assert_not_role User.last, :maintenance, @hoa
  end

  test 'moderator can invite multiple users' do
    assert_difference('User.count', 3) do
      add_multiple_members(['hello@kitty.com','woo@poo.com','zoo@poo.com'], 'role_user')
    end
    User.all[-3..-1].each do |user|
      assert_not_role user, :moderator, @hoa
      assert_not_role user, :maintenance, @hoa
    end
  end

  def add_member(email_addr, role)
    assert_difference('User.count') do
      sign_in @moderator
      click_on @hoa.name
      click_on 'new-member'
      fill_in :emails, with: email_addr
      choose role unless role == 'role_user' # User role should be default
      click_on 'Verstuur uitnodiging'
    end
    assert_equal email_addr, User.last.email
    Sidekiq::Testing.inline!
    email = ActionMailer::Base.deliveries.last
    assert_equal email_addr, email.to[0]
  end

  def add_multiple_members(email_addrs = [], role)
    sign_in @moderator
    click_on @hoa.name
    click_on 'new-member'
    emails = ""
    email_addrs.each do |e|
      emails << "#{e}\n"
    end
    fill_in :emails, with: emails
    choose role unless role == 'role_user' # User role should be default
    click_on 'Verstuur uitnodiging'
    assert_equal email_addrs.last, User.last.email
    Sidekiq::Testing.inline!
    email = ActionMailer::Base.deliveries.last
    assert_equal email_addrs.last, email.to[0]
  end
end
