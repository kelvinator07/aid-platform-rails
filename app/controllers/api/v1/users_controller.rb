class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # GET /users
  def index
    @users = User.all

    render json: success(@users), status: 200
  end

  # POST REGISTER
  def signup
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})

      render json: successnew(@user, token), status: 201
    else
      @error = @user.errors.full_messages.to_sentence
      render json: failure(@error), status: :unprocessable_entity
      # render json: {error: "Something went wrong with your credentials"}, status: 400
    end
  end

  # POST LOGGING IN
  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      token = encode_token({user_id: @user.id})
      render json: successnew(@user, token), status: 200
    else
      @error = "Invalid Credentials"
      render json: failure(@error), status: 400
    end
  end


  def auto_login
    render json: @user
  end

  private

  def user_params
    params.permit(:firstname, :lastname, :password, :email, :picture)
  end

end
