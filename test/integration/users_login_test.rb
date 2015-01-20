require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user, :category

  def setup
    @user = User.create(username: "Chris", password: "Lauren")
    @category = Category.create(name: "meals")
    user.ideas.create(name: "lunch", category_id: category.id)
    user.ideas.create(name: "dinner", category_id: category.id)
    visit login_path
  end

  def teardown
    @user.destroy!
  end

  test "user sees login page at login path" do
    skip
    assert page.has_content?("Please Login")
  end


  test "registered user can login" do
    fill_in "sesh[username]", with: "Chris"
    fill_in "sesh[password]", with: "Lauren"
    click_link_or_button "Login"
    within("#banner") do
      assert page.has_content?("Welcome, Chris")
    end
  end

  test "unregistered user cannot login" do
    fill_in "sesh[username]", with: "ChrisXX"
    fill_in "sesh[password]", with: "LaurenXX"
    click_link_or_button "Login"
    within("#errors") do
      assert page.has_content?("You typed in the wrong username/password")
    end
  end

  test "logged in user sees user's ideas" do
    ApplicationController.any_instance.stubs(:current_user).returns(user) #when you do a current user stub, you actually need a current_user method
    visit user_path(user)
    within("#banner") do
      assert page.has_content?("Welcome, Chris")
    end
  end

  # test "logged in user cannot see protected user ideas" do
  #
  # end

  test "user can logout" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)   #so it seems like we just visit directly without any authentication.
    click_link_or_button "Logout"
    assert page.has_content?("You successfully logged out")
  end

  test "user cannot look at another user's show page" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    protected_user = User.create(username: "Greg", password_digest: "narajka")
    visit user_path(protected_user)
    assert page.has_content?("Nice try asshole")
  end

  test "user logs in and sees ideas on his show page" do
    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit user_path(user)
    assert page.has_content?("lunch")

  end





end
