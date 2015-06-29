require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'role query works' do
    assert users(:volunteer_user11).has_role?(:volunteer)
    assert users(:volunteer_user11).has_role?('volunteer')
  end

  test 'admin has arbitrary roles' do
    assert users(:admin_user).has_role?('this doesn\'t matter at all')
  end

  test 'manager team scope works' do
    team = users(:manager1).volunteers.all
    assert team.include?(users(:volunteer_user11))
    assert_not team.include?(users(:volunteer_user21))
  end
end
