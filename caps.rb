require 'sinatra'
require 'date'
require 'erb'
require_relative 'errors'
require_relative 'helpers'
require_relative 'schedule'

class Caps < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :public, Proc.new { File.join(root, '/public') }

  not_found do
    erb :boom
  end

  error BadDate do
    status 400
    erb :boom
  end

  # Hit the index page looks up today
  before '/' do
    @date = get_today
  end

  get '/' do
    erb :today
  end

  get '/about' do
    erb :about
  end

  get '/faq' do
    erb :faq
  end

  # Hit '/today' also looks up today
  before %r{/today/?}i do
    @date = get_today
  end

  get %r{/today/?}i do
    erb :today
  end

  # Want '/tomorrow'?
  before %r{/tomorrow/?}i do
    @date = get_tomorrow
  end

  get %r{/tomorrow/?}i do
    erb :tomorrow
  end

  before %r{/(\d{8})/?$} do
    @date = get_by_string(params[:captures].first)
  end

  get %r{/(\d{8})/?$} do
    raise BadDate if @date.nil?
    erb :date
  end

  days = %w/monday tuesday wednesday thursday friday saturday sunday/
  days.each do |day|
    before %r{/(#{day})/?}i do
      # get the next _day_ and produce a @date var for it
      @date = get_named_day(params[:captures].first)
    end
  end

  days.each do |day|
    get %r/#{day}/i do
      erb :day
    end
  end
end
