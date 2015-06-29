require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test 'routing works' do
    assert_routing('/profile', {action: 'show', controller: 'profiles'})
  end

  test 'requires login' do
    get :show
    assert_redirected_to new_user_session_path
  end

  describe 'signed in users get to their profile' do
    before do
      @u = users(:volunteer_user11)
      devise_sign_in @u
    end

    it 'is not redirected' do
      get :show
      assert assigns(:user)
      assert_equal @u.id, assigns(:user).id
    end
  end

  describe 'managers screen' do
    before do
      @manager1 = users(:manager1)
    end

    it 'sees signed in counts correctly' do

      u11 = users(:volunteer_user11)
      u11.sign_in_count = 33; u11.save
      u12 = users(:volunteer_user12)
      u12.sign_in_count = 44; u12.save

      devise_sign_in @manager1
      get :show
      counts = []
      assert_select('.volunteers-table .sign-in-count') do |elts|
        elts.each do |elt|
          matches = /(\d+)/.match elt.text
          counts << matches[1]
        end
      end

      assert_equal 2, counts.size
      assert counts.include?('33')
      assert counts.include?('44')
    end
  end
end
