class Admin::MemoriesController < Admin::ForestController
  before_action :set_memory, only: [:show, :edit, :update, :destroy]

  def index
    @memories = apply_scopes(Memory).by_id.page(params[:page])
  end

  def show
    authorize @memory
  end

  def new
    @memory = Memory.new
    authorize @memory
  end

  def edit
    authorize @memory
  end

  def create
    @memory = Memory.new(memory_params)
    authorize @memory

    if @memory.save
      redirect_to edit_admin_memory_path(@memory), notice: 'Memory was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @memory

    if @memory.update(memory_params)
      redirect_to edit_admin_memory_path(@memory), notice: 'Memory was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @memory
    @memory.destroy
    redirect_to admin_memories_url, notice: 'Memory was successfully destroyed.'
  end

  private

    def memory_params
      # Add blockable params to the permitted attributes if this record is blockable `**BlockSlot.blockable_params`
      params.require(:memory).permit(:slug, :status, :title, :date, :description, **BlockSlot.blockable_params)
    end

    def set_memory
      @memory = Memory.find(params[:id])
    end
end
