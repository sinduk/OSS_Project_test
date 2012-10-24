require File.dirname(__FILE__) + '/../test_helper'
require 'response_controller'
require 'test_helper'
#Display exceptions from controller
class ResponseControllerTest < ActionController::TestCase
def rescue_action(a) raise a end;
end
class ResponseControllerTest < ActionController::TestCase

 fixtures :questionnaires
 fixtures :users
 fixtures :question_advices
 fixtures :questions
 fixtures :users, :roles, :system_settings, :content_pages, :permissions, :roles_permissions, :controller_actions, :site_controllers, :menu_items
 fixtures :response_maps
 set_fixture_class :system_settings => 'SystemSettings'
 set_fixture_class :roles_permissions => 'RolesPermission'
 fixtures :users

 def setup


   @controller = ResponseController.new
   @request    = ActionController::TestRequest.new
   @response   = ActionController::TestResponse.new

   @request.session[:user] = User.find(users(:admin).id )
   roleid = User.find(users(:admin).id).role_id
   Role.rebuild_cache

   Role.find(roleid).cache[:credentials]
   @request.session[:credentials] = Role.find(roleid).cache[:credentials]
   @request.session[:credentials] = nil if @request.session[:credentials].is_a? YAML::Object
   @settings = SystemSettings.find(:first)

   AuthController.set_current_role(roleid,@request.session)
  end

  #CRUD test cases
 def test_rereview
   # assert_difference('Response.count') do
  #    post :create => { }
  #  assert_response :success
    id = response_maps(:response_maps0).id
    #puts "id  = #{id}"
    post :rereview  , {:id => id ,  :feedback => nil} , session_for(users(:admin))
    assigns(:sorted_array)
  end

 end



