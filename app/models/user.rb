class User < ApplicationRecord
    # Bcrypt ile şifreleme
    has_secure_password
    has_many :articles
    # E-posta doğrulama
    validates :email, presence: true, uniqueness: true
  
    # JWT ile token oluşturma
    def self.generate_token(user_id)
      payload = { user_id: user_id, exp: 5.hours.from_now.to_i }
      secret_key =  ENV['JWT_SECRET']

      JWT.encode(payload, secret_key, 'HS256')
    end
  
    # JWT ile token çözme
    def self.decode_token(token)
      secret_key = ENV['JWT_SECRET']
      return nil if token.nil?
    
      begin
        decoded = JWT.decode(token, secret_key, true, algorithm: 'HS256').first
        HashWithIndifferentAccess.new(decoded)
      rescue JWT::ExpiredSignature
        Rails.logger.error "Token süresi dolmuş."
        return nil
      rescue JWT::DecodeError => e
        Rails.logger.error "JWT Decode Error: #{e.message}"
        return nil
      end
    end
  end
  