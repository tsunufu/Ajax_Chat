require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'json'
require 'open-uri'
require 'net/http'

require './models'

get '/' do
# 　@comments = Comment.order('id desc')
  erb :index
end

post '/comment' do

  Comment.create({
    body: params[:body],
    user_name: params[:user_name]
  })
end

get '/comments/last' do
  comment = Comment.last
  {body: comment.body, user_name: comment.user_name}.to_json
end