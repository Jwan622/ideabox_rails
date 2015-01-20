require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  attr_reader :category

  def setup
    @category = Category.create(:name => "national parks")
    @idea1 = Idea.create(:name => "red rock canyon", category_id: category.id)
    @idea2 = Idea.create(:name => "adirondacks", category_id: category.id)
  end

  def test_it_is_valid
    assert category.valid?
  end

  def test_it_is_invalid
    category.name = nil
    refute category.valid?
  end

  def test_category_can_have_ideas
    assert_equal 2, category.ideas.count
  end
end
