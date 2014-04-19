module RoleTestHelper
  def assert_role(user, role, object)
    assert user.has_role?(role, object), "#{user} should have role #{role} for #{object}"
  end

  def assert_not_role(user, role, object)
    assert ! user.has_role?(role, object), "#{user} should not have role #{role} for #{object}"
  end
end
