class LearningItemsController < ApplicationController
  before_action :set_learning_item, only: %i[ edit update destroy toggle_mark_as_learned ]
  before_action :authenticate_user!

  def toggle_mark_as_learned
    respond_to do |format|
      if @learning_item.update(is_learned: !@learning_item.is_learned)
        message = "Learning item was successfully marked as #{'not' unless @learning_item.is_learned} learned."
        format.html { redirect_to dashboard_path, notice: message }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # Dashboard. GET /learning_items
  def index
    @learning_items = current_user.learning_items.order(created_at: :desc)
  end

  # GET /learning_items/new
  def new
    @learning_item = LearningItem.new
  end

  # GET /learning_items/1/edit
  def edit
  end

  # POST /learning_items
  def create
    @learning_item = current_user.learning_items.new(learning_item_params)

    respond_to do |format|
      if @learning_item.save
        format.html { redirect_to dashboard_path, notice: "Learning item was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /learning_items/1 or /learning_items/1.json
  def update
    respond_to do |format|
      if @learning_item.update(learning_item_params)
        format.html { redirect_to dashboard_path, notice: "Learning item was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /learning_items/1 or /learning_items/1.json
  def destroy
    @learning_item.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: 'Learning item was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_learning_item
      @learning_item = LearningItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def learning_item_params
      params.require(:learning_item).permit(:title, :confusing_part, :is_learned, :documentation)
    end
end
