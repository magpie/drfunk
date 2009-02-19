require 'test_helper'

class HelperTest < ActiveSupport::TestCase
  include ActionView::Helpers
  include SearchHelper

  should "highlight a query" do
    my_text = "123aBc456"
    result = highlight_query(my_text, "abc")
    assert_equal "123<strong class=\"highlight\">aBc</strong>456", result
  end

  should "get an excerpt from a search and higlight the matching peice" do
    my_text = "my excerpt test please cut me off soon! 123aBc456 my excerpt test please cut me off soon!"
    result = highlight_query_excerpt(my_text, "abc")
    expected = "...cut me off soon! 123<strong class=\"highlight\">aBc</strong>456 my excerpt test..."
    assert_equal expected, result
  end

end
