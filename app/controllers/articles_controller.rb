# require "application_controller" # DON'T DO THIS.

=begin
Application classes and modules are available everywhere,
you do not need and should not load anything
under app with require. This feature is called
autoloading, and you can learn more about it in
Autoloading and Reloading Constants.
https://guides.rubyonrails.org/autoloading_and_reloading_constants.html
=end

=begin
You only need require calls for two use cases:

1. To load files under the lib directory.
2. To load gem dependencies that have require: false in the Gemfile.
=end

class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  # The new action instantiates a new article, but does not save it.
  # This article will be used in the view when building the form. # By default, the new action will render app / views / articles / new.html.erb
  # The create action instantiates a new article with values for the
  # title and body, and attempts to save it. If the article is saved
  # successfully, the action redirects the browser to the article's
  # page at "http://localhost:3000/articles/#{@article.id}". Else, the
  # action redisplays the form by rendering app/views/articles/new.html.erb
  # with status code 422 Unprocessable Entity.

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
      # redirect_to will cause the browser to make a new request, whereas
      # render renders the specified view for the current request.
      # It is important to use redirect_to after mutating the database
      # or application state. Otherwise, if the user refreshes the page,
      # the browser will make the same request, and the mutation will
      # be repeated.
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

end
