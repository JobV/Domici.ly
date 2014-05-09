require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test 'commenting on an alert adds you to the collaborators' do
    hoa   = create(:hoa)
    user  = create(:user, hoa: hoa)
    alert = create(:alert, hoa: hoa, user: create(:user))

    sign_in user
    visit alert_path(alert)
    fill_in 'comment_comment', with: 'This is a comment.'
    assert_difference("Comment.count") do
      click_on 'Plaats Reactie'
    end

    assert Alert.last.collaborations.exists?(user: user), 'Commenter should be in the collaborators.'
  end
end
