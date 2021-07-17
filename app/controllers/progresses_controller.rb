class ProgressesController < ApplicationController
  before_action :set_progress, only: %i[ show edit update destroy ]

  # GET /progresses or /progresses.json
  def index
    @progresses = Progress.all
    @progresses =@progresses.sort_by{|x| [Date.today - x.expires_at]}
  end

  # GET /progresses/1 or /progresses/1.json
  def show
  end

  # GET /progresses/new
  def new
    @progress = Progress.new
  end

  # GET /progresses/1/edit
  def edit
  end

  # POST /progresses or /progresses.json
  def create
    @progress = Progress.new(progress_params)
    @progress.user_id = current_user.id
    @progress.expires_at = Date.today
    reports = Report.where('owner_id = ?',@progress.user_id ).where('creation_date = ?',@progress.expires_at )
    totalB = 0
    totalC = 0
    @final_porcent = 0
    reports.each do |report|
     
      if totalB > @progress.burnedCalories && totalC >@progress.burnedCalories
        @final_porcent = 100
        break
      else
         totalB = totalB + report.burnedCalories
         totalC = totalC + report.consumedCalories
      end
    end
    
    @progress.burnedObjetive = totalB
    @progress.consumedObjetive = totalC
    
    if @final_porcent != 100
      @final_porcent = (((@progress.burnedObjetive+@progress.consumedObjetive) * 100)/(@progress.consumedCalories+@progress.burnedCalories)).to_i
    end
    @progress.porcent = @final_porcent
    

    respond_to do |format|
      if @progress.save
        format.html { redirect_to @progress, notice: "Progress was successfully created." }
        format.json { render :show, status: :created, location: @progress }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /progresses/1 or /progresses/1.json
  def update
    
    respond_to do |format|
      if @progress.update(progress_params)
        format.html { redirect_to @progress, notice: "Progress was successfully updated." }
        format.json { render :show, status: :ok, location: @progress }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /progresses/1 or /progresses/1.json
  def destroy
    @progress.destroy
    
    respond_to do |format|
      format.html { redirect_to progresses_url, notice: "Progress was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_progress
      @progress = Progress.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def progress_params
      params.require(:progress).permit(:expires_at, :consumedCalories, :burnedCalories, :user_id, :porcent, :burnedObjetive, :consumedObjetive)
    end
end
