class ApplicationController < ActionController::API
    include Response
    before_action :authorized

      # secret to encode and decode token
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    def encode_token(payload)
      JWT.encode(payload, ENV['TOKEN_SECRET_KEY'])
    end
  
    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end
  
    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, ENV['TOKEN_SECRET_KEY'])
          # JWT.decode(token, ENV['TOKEN_SECRET_KEY'], true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def logged_in_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end
    end
  
    def logged_in?
      !!logged_in_user
    end
  
    def authorized
      render json: failure('Please log in'), status: :unauthorized unless logged_in?
      # render json: failure('Please log in'), status: :unprocessable_entity
    end

    def responsenew(value)
      response = {
        status: "00",
        message: "Success",
        data: value.as_json()
      }
    end

    def success(value)
      response = {
        status: "00",
        message: "Success",
        data: {
          # total: value.size, 
          users: value.as_json(except: [:password_digest, :updated_at])
        }
      }
    end
  
    def successnew(value, token)
      response = {
        status: "00",
        message: "Success",
        data: {
          user: value.as_json(except: [:password_digest, :updated_at]),
          token: token
        }
      }
    end
  
    def failure(value)
      response = {
        status: "99",
        message: value,
        data: "null"
      }
    end

end
