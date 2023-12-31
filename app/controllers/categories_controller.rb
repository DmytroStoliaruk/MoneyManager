class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    # set filter in categories by substring of name 
    if params.key?(:category_sub_name) 
      sub_name = params[:category_sub_name] + "%"
    else
      sub_name = "%"
    end
    @categories = Category.where("name LIKE ?", sub_name).page params[:page]
  end

  # GET /categories/1 or /categories/1.json
  def show
    redirect_to categories_path
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save      
        format.html { redirect_to category_url(@category), notice: "Категорія '" + @category.name + "' була успішно створена." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { redirect_to new_category_path, notice: "Нова категорія не створена. Помилка: " + @category.errors.messages.to_s }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to category_url(@category), notice: "Категорія " + @category.name + " була успішно змінена." }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { redirect_to edit_category_path(@category), notice: "Категорія " + @category.name + " не змінена. Помилка: " + @category.errors.messages.to_s }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    begin
      @category.destroy
    rescue => exception
      redirect_to categories_url, notice: "Категорія " + @category.name + " не може бути вилучена поки не видалені всі операції по цій категорії."
    else 
      respond_to do |format|
        format.html { redirect_to categories_url, notice: "Категорія " + @category.name + " була успішно вилучена." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :description)
    end
end
