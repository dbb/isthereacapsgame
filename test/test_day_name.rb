require_relative './helper'
require_relative '../helpers'

class TestDayNames < TestCapsApp
  def test_monday
    get '/monday'
    assert_equal 200, last_response.status
  end

  def test_tuesday
    get '/tuesday'
    assert_equal 200, last_response.status
  end

  def test_wednesday
    get '/wednesday'
    assert_equal 200, last_response.status
  end

  def test_thursday
    get '/thursday'
    assert_equal 200, last_response.status
  end

  def test_friday
    get '/friday'
    assert_equal 200, last_response.status
  end

  def test_saturday
    get '/saturday'
    assert_equal 200, last_response.status
  end

  def test_sunday
    get '/sunday'
    assert_equal 200, last_response.status
  end
end

class TestDayNamesFunkyCaps < TestCapsApp
  def test_monday
    get '/MoNdAY'
    assert_equal 200, last_response.status
  end

  def test_tuesday
    get '/TUESDAY'
    assert_equal 200, last_response.status
  end

  def test_wednesday
    get '/WEDnesDAY'
    assert_equal 200, last_response.status
  end

  def test_thursday
    get '/THurSDay'
    assert_equal 200, last_response.status
  end

  def test_friday
    get '/FRIday'
    assert_equal 200, last_response.status
  end

  def test_saturday
    get '/SATurdAy'
    assert_equal 200, last_response.status
  end

  def test_sunday
    get '/SUNDAy'
    assert_equal 200, last_response.status
  end
end

class TestDynamicDayResponse < TestCapsApp
  def test_monday
    get '/monday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Monday?'), body
  end

  def test_tuesday
    get '/tuesday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Tuesday?'), body
  end

  def test_wednesday
    get '/wednesday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Wednesday?'), body
  end

  def test_thursday
    get '/thursday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Thursday?'), body
  end

  def test_friday
    get '/friday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Friday?'), body
  end

  def test_saturday
    get '/saturday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Saturday?'), body
  end

  def test_sunday
    get '/sunday'
    doc = Nokogiri::HTML(last_response.body)
    body = doc.xpath('//p//text()').text
    assert body.include?('Sunday?'), body
  end
end

class TestDayJumpsOverToday < TestCapsApp
  def test_today_is_skipped_over
    today = DateTime.now
    # in order to get at the helper method, I need some sleight-of-hand
    next_today = Caps.new!.get_named_day(today.strftime("%A"))
    assert today != next_today
  end

  def test_next_week_this_day
    require 'date'
    today = DateTime.strptime(DateTime.now.strftime("%Y%m%d"), fmt="%Y%m%d")
    # in order to get at the helper method, I need some sleight-of-hand
    next_today = Caps.new!.get_named_day(today.strftime("%A"))
    7.times do
      today = today.next_day
    end
    assert today.eql?(next_today),
      "#{today.strftime("%Y%m%d")} #{next_today.strftime("%Y%m%d")}"
  end
end
