require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'json'
require 'open-uri'
require 'net/http'

require './models'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
# 　@comments = Comment.order('id desc')
  @comments = Comment.all
  erb :index
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect '/'
end

post '/signup' do
    @user = User.create(name:params[:name], password:params[:password],
    password_confirmation:params[:password_confirmation])
    if @user.persisted?
        session[:user] = @user.id
    end
    redirect '/'
end

get '/signout' do
    session[:user] = nil
    redirect '/'
end


post '/comment' do

  Comment.create({
    user_id: session[:user],
    body: params[:body],
    user_name: params[:user_name]
  })
end

get '/comments/last' do
  comment = Comment.last
  {body: comment.body, user_id: current_user.name}.to_json
end