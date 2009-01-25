require 'test_helper'

class HelperTest < ActiveSupport::TestCase
  include ActionView::Helpers
  include SearchHelper

  should "return empty for no search results" do
    @query = nil
    feature = Factory(:feature)
    assert_equal "", search_feature_result(feature)
    @query = "abc"
    assert_equal "", search_feature_result(feature)
  end

  should "test if attributes matches query" do
    @query = "ABC"
    assert_equal false, include_query(nil)
    assert_equal false, include_query("")
    assert_equal false, include_query("A B C")

    assert include_query("testABCtest")
    assert include_query("testabctest")
  end

  should "highlight a query" do
    @query = "abc"
    my_text = "123aBc456"
    result = highlight_query(my_text)
    assert_equal "123<strong class=\"highlight\">aBc</strong>456", result
  end

  should "get an excerpt from a search and higlight the matching peice" do
    @query = "abc"
    my_text = "my excerpt test please cut me off soon! 123aBc456 my excerpt test please cut me off soon!"
    result = highlight_query_excerpt(my_text)
    expected = "...cut me off soon! 123<strong class=\"highlight\">aBc</strong>456 my excerpt test..."
    assert_equal expected, result
  end

end
