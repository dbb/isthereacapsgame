require_relative './helper'

class Test404Response < TestCapsApp
  def test_no_such_page
    get '/no-such-page'
    assert_equal 404, last_response.status
  end

  def test_bad_date
    get '/20105034'
    assert_equal 400, last_response.status
  end
end
