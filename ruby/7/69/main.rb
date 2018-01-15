require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'mongo'
require 'open-uri'
require 'nokogiri'
require 'pry'

helpers do
  def time(hash)
    return if hash.nil?
    [hash.dig('year'), hash.dig('month'), hash.dig('date')].compact.join('.')
  end

  def display_count(count)
    (count <= 1) ? "#{count} result:" : "#{count} results:"
  end
end

before do
  @client = Mongo::Client.new(['127.0.0.1:27017'], database: '64')
  @collection = @client[:artists]
  cache_control :public, :must_revalidate
end

get '/' do
  @name = params['name']&.strip
  @area = params['area']&.strip
  @tags = params['tags']&.split(/\s*,\s*/)
  @limit = params['limit'].to_i == 0 ? 10 : params['limit'].to_i

  query = {}
  if @name.present?
    query['$or'] = [
      { 'name': /#{@name}/i },
      { 'aliases.name': /#{@name}/i }
    ]
  end
  query['area'] = @area if @area.present?
  query['tags.value'] = { '$all': @tags } if @tags.present?

  @artists = @collection.find(query).sort({ 'rating.value': -1 }).limit(@limit)

  @artists = @artists.map do |artist|
    url = "https://www.google.co.jp/search?"
    params = {
      q: "#{artist['name']} artist",
      tbs: 'isch'
    }

    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)

    html = open(uri) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, nil)
    artist['image'] = doc.css('img').first&.attribute('src')&.value
    artist
  end

  erb :index
end
