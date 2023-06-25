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
        format.html { render :new, status: :unprocessable_entity }
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
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1 or /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_path(category_id: @operation.category_id), notice: "Operation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    def set_category
      @categories = Category.all.map{ |c| [ c.name, c.id ] }
      if params.key?(:category_id)
        @category_id = params[:category_id]
      else
        @category_id = Category.first.id
      end  
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:amount, :odate, :description, :category_id)
    end
end
