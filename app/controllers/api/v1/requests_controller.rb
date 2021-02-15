class Api::V1::RequestsController < ApplicationController

    # GET /requests
    def index
      @requests = Request.all
      # json_response(@requests)
      render json: { total: @requests.size, requests: @requests }, status: 200
    end

     # GET /requests by user
     def userrequests
      @requests = Request.where(user_id: params[:user_id])
      # json_response(@requests)
      render json: { total: @requests.size, requests: @requests }, status: 200
    end

    # POST /requests
    def create
      # create requests belonging to current user
      # @request = current_user.requests.create!(request_params)
      # @request = Request.new(request_params)
      @user = logged_in_user
      if @user
        #@request = Request.new
        @request = @user.requests.create!(request_params)
        #@request = Request.create!(request_params)
        
        # render json: responsenew(@request), status: 201
        if @request.valid?
          render json: responsenew(@request), status: 201
        else
          @error = @request.errors.full_messages.to_sentence
          render json: failure(@error), status: :unprocessable_entity
        end

      else
        @error = @user.errors.full_messages.to_sentence
        render json: failure(@error), status: :unprocessable_entity
      end
      

      

    end

    # GET /requests/:id
    def show
      json_response(@request)
    end

    # PUT /requests/:id
    def update
      @request = Request.find(params[:id])

      if @request.update(update_params)
        render json: responsenew(@request), status: 200
      else
        @error = @request.errors.full_messages.to_sentence
        render json: failure(@error), status: :unprocessable_entity
      end
    end

    # DELETE /requests/:id
    def destroy
      @request.destroy
      head :no_content
    end

    private

    def request_params
      # whitelist params
      params.permit(:description, :request_type, :lat, :lng, :fulfilcount)
      #params.require(:request).permit(:description, :type, :lat, :lng)

    end

    def update_params
      # whitelist params
      params.permit(:description, :request_type, :lat, :lng, :fulfilcount, :id, :fulfilled, :created_at, :updated_at, :user_id)
      #params.require(:request).permit(:description, :type, :lat, :lng)

    end

    def set_request
      @request = Request.find(params[:id])
    end
end
