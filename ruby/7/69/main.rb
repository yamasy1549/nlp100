require 'sinatra'
require 'sinatra/reloader'
require 'active_record'
require 'mongo'
require 'pry'

helpers do
  def time(hash)
    return if hash.nil?
    [hash.dig('year'), hash.dig('month'), hash.dig('date')].compact.join('.')
  end
end

before do
  client = Mongo::Client.new(['127.0.0.1:27017'], database: '64')
  @collection = client[:artists]
end

get '/' do
  @name = params['name']&.strip
  @area = params['area']&.strip
  @tags = params['tags']&.split(/\s*,\s*/)

  query = {}
  if @name.present?
    query['$or'] = [
      { 'name': /#{@name}/i },
      { 'aliases.name': /#{@name}/i }
    ]
  end
  query['area'] = @area if @area.present?
  query['tags.value'] = { '$all': @tags } if @tags.present?

  @artists = @collection.find(query).sort({ 'rating.value': -1 }).limit(100)

  erb :index
end
