require 'test_helper'

class AppointmentRequestsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test 'routing' do
    assert_routing({method: :post, path: '/appointment_requests'}, {controller: 'appointment_requests',
                                                                    action: 'create'})
  end

  test 'a request requires a manager login' do
    sign_in(users(:volunteer_user11))

    get :new
    assert_match /not.authorized/i, flash[:alert]
  end

  describe 'For managers' do
    before do
      sign_in(users(:manager1))
    end      
    it 'can see the request form' do
      t_now = Time.new(2015, 1, 1) + 3.hours
      Time.stubs(:now).returns(t_now)
      get :new

      assert_select('#appointment_request_request_time_2i option[selected=selected]', 1) do |elt|
        assert_equal 'January', elt[0].text
      end
      assert_select('#appointment_request_request_time_3i option[selected=selected]', 1) do |elt|
        assert_equal '2', elt[0].text
      end
    end
  end

  describe 'for volunteers' do
    before do
      devise_sign_in users(:volunteer_user11)
    end
    
    it 'can view its appointments' do
      get :show, {id: appointment_requests(:request_11)}

      assert_template :show
    end
    it 'cannot view other appointments' do
      get :show, {id: appointment_requests(:request_12)}
      assert_redirected_to '/'
    end
  end
end
