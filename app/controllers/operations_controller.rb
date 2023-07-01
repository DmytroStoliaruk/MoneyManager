class OperationsController < ApplicationController
  before_action :set_operation, only: %i[ show edit update destroy ]
  before_action :set_category, only: %i[ index new show edit update destroy ]

  # GET /operations or /operations.json
  def index
    @operations = Operation.where(category_id: @category_id).order(:odate).page params[:page]
  end

  # GET /operations/1 or /operations/1.json
  def show
    # redirect_to operations_path
  end

  # GET /operations/new
  def new
    @operation = Operation.new
    @operation.odate = Date.today
  end
 
  # GET /operations/1/edit
  def edit  
  end

  # POST /operations or /operations.json
  def create
    @operation = Operation.new(operation_params)
    respond_to do |format|
      if @operation.save
        format.html { redirect_to operations_path(category_id: @operation.category_id), notice: "Операцію було успішно створено." }
        format.json { render :show, status: :created, location: @operation }
      else    
        format.html { redirect_to new_operation_path, notice: "Нова операція не створена. Помилка: " + @operation.errors.messages.to_s }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /operations/1 or /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to operations_path(category_id: @operation.category_id), notice: "Операцію було успішно змінено." }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { redirect_to edit_operation_path(@operation), notice: "Операція не змінена. Помилка: " + @operation.errors.messages.to_s }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_path(category_id: @operation.category_id), notice: "Операцію було успішно в далено..." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    def set_category
      # if database is empty go to main page...
      if Category.count == 0 
        return redirect_to root_path
      end

      if params.key?(:category_id)
        @category_id = params[:category_id]
      else
        @category_id = Category.first.id
      end  
      @categories = Category.all.map{ |c| [ c.name, c.id ] }
      @category_name = Category.find_by(id: @category_id).name
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id)
    end
end
