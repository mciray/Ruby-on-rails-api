
class UsersController < ApplicationController
    before_action :authorize_request, except: [:login, :signup]

    # Kullanıcı Kaydı (Signup)
    def signup
    @user = User.new(user_params)
    if @user.save
        render json: { user: @user}, status: :created
    else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
    end

    # Kullanıcı Girişi (Login)
    def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
        token = User.generate_token(@user.id)
        render json: { token: token }, status: :ok
    else
        render json: { errors: 'Geçersiz e-posta veya şifre' }, status: :unauthorized
    end
    end

    # Kullanıcı Bilgileri (Token ile yetkilendirme)
    def profile
    render json: { user: @current_user }
    end

    private

    def user_params
    params.permit(:name, :email, :password)
    end

    def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = User.decode_token(header)
    @current_user = User.find(decoded[:user_id]) if decoded
    rescue ActiveRecord::RecordNotFound
    render json: { errors: 'Yetkilendirme başarısız' }, status: :unauthorized
    end
end
