require_relative './helper'

class TestRootPage < TestCapsApp
  def setup
    get '/'
    doc = Nokogiri::HTML(last_response.body)
    @title = doc.xpath('//title/text()').text
    @body = doc.xpath('//p//text()').text
  end

  def test_get_index
    assert_equal 200, last_response.status
  end

  def test_index_title
    assert_equal 'Is there a Caps game?', @title
  end

  def test_index_static_content
    assert @body.include?('Is there a Caps game today?'), @body
  end

  def test_index_dynamic_content
    if last_response.body.include?('YES!')
      assert @body.include?('Puck drops'), @body
    else
      assert @body.include?('No.'), @body
      assert @body.include?('The next game is'), @body
    end
  end
end

class TestTodayPage < TestCapsApp
  def setup
    get '/today'
    doc = Nokogiri::HTML(last_response.body)
    @body = doc.xpath('//text()').text
  end

  def test_get_today_by_name
    assert_equal 200, last_response.status
  end

  def test_today_static_content
    assert @body.include?('Is there a Caps game today?'), @body
  end

  def test_today_dynamic_content
    if last_response.body.include?('YES!')
      assert @body.include?('Puck drops')
    else
      assert @body.include?('No.'), @body
      assert @body.include?('The next game is'), @body
    end
  end
end

class TestFunkyCapitalization < TestCapsApp
  def test_get_TODAY
    get '/TODAY'
    assert_equal 200, last_response.status
  end

  def test_get_ToDaY
    get '/ToDaY'
    assert_equal 200, last_response.status
  end
end

class TestGameToday < TestCapsApp
  # The following feels hacky to me, but it's tricky.
  # I don't know _when_ the tests will be run, so checking whether
  # there's an actual game 'today' is pointless.
  #
  # Instead, I fudge it by removing today's game (if there is one) and
  # then adding a fake game (as a known test subject).
  def setup
    @today = Caps.new!.get_today
    SCHEDULE.delete(@today) if SCHEDULE[@today]
    @game = ["Capitals vs. Capitals", "7:00 PM", "home"]
  end

  def test_no_game_today
    get '/'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//text()').text
    assert body.include?('No.')
    assert body.include?('The next game is')
  end

  def test_game_today
    SCHEDULE[@today] = @game
    get '/'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//text()').text
    assert body.include?('YES!'), body
    assert body.include?('Capitals vs. Capitals'), body
  end
end
