class ArticlesController < ApplicationController
  #before_action :authenticate_user!

  def accueil
    @articles = Article.order('created_at desc').limit(3)
  end

  def index
    @articles = Article.all
  end

  def blog
    @articles = Article.all
    @articles = Article.paginate(:page => params[:page])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      flash[:success] = "Votre article a bien été créé"
      redirect_to @article
    else
      render 'create'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:user_id, :titre, :contenu)
  end
end
