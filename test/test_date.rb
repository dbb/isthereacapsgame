require_relative './helper'

class TestDateWithoutGame < TestCapsApp
  def setup
    get '/20110919'
    doc = Nokogiri::HTML(last_response.body)
    @title = doc.xpath('//title/text()').text
    @body = doc.xpath('//p//text()').text
  end

  def test_response_status
    assert_equal 200, last_response.status
  end

  def test_answer
    assert @body.include?('Is there a Caps game on September 19th?')
    assert @body.include?('No.')
    assert @body.include?('The next game is')
  end
end
