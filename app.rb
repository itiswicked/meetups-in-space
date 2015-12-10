require 'sinatra'
require_relative 'config/application'

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def logged_in?
    session[:user_id].present?
  end

  def user_joined?(meetup)
    meetup.users.map(&:id).include?(session[:user_id])
  end
end

get '/' do
  redirect '/meetups'
end

get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @meetups = Meetup.all
  erb :'meetups/index'
end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  @button_text = user_joined?(@meetup) ? "Leave Meetup" : "Join!"
  erb :'meetups/show'
end

get '/meetups_new' do
  if logged_in?
    erb :'meetups/new'
  else
    flash.next[:notice] = ['You must be logged in to perform that action.']
    redirect '/'
  end
end

post '/meetups' do
  @meetup = Meetup.new(
    name: params[:name],
    description: params[:description],
    location: params[:location],
    user_id: session[:user_id]
  )

  if @meetup.save
    @meetup.users << current_user
    redirect "/meetups/#{@meetup.id}"
  else
    flash.next[:notice] = @meetup.errors.full_messages
    redirect '/meetups_new'
  end
end

get '/meetups_edit/:id' do
  @meetup = Meetup.find(params[:id])
  if logged_in? && @meetup.user_id == current_user.id
    erb :'meetups/edit'
  else
    flash.next[:notice] = ["Something went wrong"]
    redirect '/meetups/:id'
  end
end

put '/meetups_update/:id' do
  @meetup = Meetup.find(params[:id])
  # params.each do |key, value|
  #   @meetup.send("#{key}=", value) if @meetup.respond_to? key
  # end

  @meetup.name = params[:name]
  @meetup.description = params[:description]
  @meetup.location = params[:location]
  if @meetup.save
    redirect "/meetups/#{params[:id]}"
  else
    flash.now[:notice] = @meetup.errors.full_messages
    erb :'/meetups/edit'
  end
end


get '/meetups_delete/:id' do
  @meetup = Meetup.find(params[:id])
  @meetup.destroy
  flash.next[:notice] = ["Meetup successfully deleted"]
  redirect '/'
end

post '/meetups_join.json' do
  content_type :json
  @meetup = Meetup.find(params[:meetup_id])
  @user   = User.find(session[:user_id])
  @meetup.users << @user
  @user.to_json
end

post '/meetups_leave.json' do
  content_type :json
  @meetup = Meetup.find(params[:meetup_id])
  @user   = User.find(session[:user_id])
  @meetup.users.delete @user
  { id: @user.id }.to_json
end
