class ArticlesController < ApplicationController
  before_action :authorize_request, except: [:index, :show]
  before_action :set_article, only: %i[ show update destroy ]

  # GET /articles
  def index
    @articles = Article.all

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    @article = @current_user.articles.build(article_params)
    if @article.save
      render json: @article, status: :created, serializer: ArticleSerializer
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body)
    end
    def authorize_request
      header = request.headers['Authorization']
      p "Authorization Header: #{header}" 
    
      if header.nil?
        return render json: { errors: 'Authorization token eksik' }, status: :unauthorized
      end
    
      token = header.split(' ').last
      p "Token: #{token}"  
    
      begin
        decoded = User.decode_token(token)
        p "Decoded Token: #{decoded}"  
        
        if decoded.nil?
          return render json: { errors: 'Geçersiz token' }, status: :unauthorized
        end
        
        @current_user = User.find(decoded[:user_id])
        p "Current User: #{@current_user.inspect}" 
    
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'Yetkisiz erişim' }, status: :unauthorized
      rescue JWT::DecodeError => e
        p "JWT DecodeError: #{e.message}" 
        render json: { errors: 'Geçersiz token' }, status: :unauthorized
      end
    end
end
