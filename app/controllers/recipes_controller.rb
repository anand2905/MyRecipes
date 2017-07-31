class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :update, :show, :like]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]

  def index
  	@recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def show
  	#@recipe = Recipe.find(params[:id])
  end

  def new
  	@recipe = Recipe.new
  end

  def create
  	@recipe = Recipe.new(recipe_params)
  	@recipe.chef = current_user

  	if @recipe.save
  	   	flash[:success] = "your recipe was created succesfully!"
  	   	redirect_to recipes_path
  	else
  		render :new
  	end
  end

  def edit
   # @recipe = Recipe.find(params[:id])
  end

  def update
   # @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated sucessfully!"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def like
    #@recipe = Recipe.find(params[:id])
   like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
     if like.valid?
     flash[:success] = "Your selection was succesful"
     redirect_back(fallback_location: root_path)
     else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_back(fallback_location: root_path)
     end
  end





  private 

  def recipe_params
  	params.require(:recipe).permit(:name, :summary, :description, :picture)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_user != @recipe.chef
    flash[:danger] = "You can only edit your own Recipes"
    #redirect_to :back
    #redirect_to recipes_path
    redirect_back(fallback_location: recipe_path)

  end
  end
end
