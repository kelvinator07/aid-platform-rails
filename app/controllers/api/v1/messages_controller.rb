class Api::V1::MessagesController < ApplicationController

  # GET /messages
  def index
    @messages = Message.all
    # json_response(@messages)
    render json: { total: @messages.size, messages: @messages }, status: 200
  end

  # POST /messages
  def create
    # create messages belonging to current user
    # @message = current_user.messages.create!(message_params)
    # @message = Message.new(message_params)
    @user = logged_in_user
    if @user
      @message = Message.new(message_params)      
      if @message.save
        render json: responsenew(@message), status: 201
      else
        @error = @message.errors.full_messages.to_sentence
        render json: failure(@error), status: :unprocessable_entity
      end

    else
      @error = @user.errors.full_messages.to_sentence
      render json: failure(@error), status: :unprocessable_entity
    end

  end

  # GET /messages/:id
  def show
    json_response(@message)
  end

  # GET /messages/:request_id
  def message
    @request_id = params[:request_id]
    @messages = Message.where(request_id: @request_id)

    # render json: responsenew(@message), status: 201
    if @messages
      render json: { total: @messages.size, messages: @messages }, status: 200
    else
      render json: { total: 0, messages: [] }, status: 200
    end

  end

  # GET /messagebyuser/:user_id
  def messagebyuser
    user_id = params[:user_id]

    @messages = Message.find_by_sql("SELECT * from messages WHERE request_id IN (SELECT id FROM requests WHERE user_id = #{user_id})")

    if @messages
      render json: { total: @messages.size, messages: @messages }, status: 200
    else
      render json: { total: 0, messages: [] }, status: 200
    end

  end

  private

  def message_params
    # whitelist params
    params.permit(:body, :name, :request_id)

  end

  def set_request
    @message = Message.find(params[:id])
  end

end
