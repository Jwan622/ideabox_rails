require 'test_helper'

class CreateIdeaTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user

  def setup
    @user = User.create(username: "Chris", password: "Lauren")
    visit "/login"
  end

  test "a user can create an idea" do
    fill_in "sesh[username]", with: "Chris"
    fill_in "sesh[password]", with: "Lauren"
    click_button "Login"
    click_link "Create Idea"
    fill_in "ideas[name]", with: "Halalz"
    click_button "Save Ideas"
    assert page.has_content?("Halalz")
  end
end
