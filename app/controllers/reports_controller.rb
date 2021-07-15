class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  require 'will_paginate/array' 
  # GET /reports or /reports.json
 def index
    @reports = Report.where('owner_id = ?', current_user.id)
    @dates = @reports.distinct.pluck(:creation_date)

    @finalReports = []
    @dates.each do |date|
      reportAux = @reports.where('creation_date = ?', date)
      burnedCaloriesAux = 0
      consumedCaloriesAux = 0
      diferenceAux = 0
      typeAux = nil
      dateAux = nil
      reportAux.each do |reporte|
        burnedCaloriesAux = burnedCaloriesAux + reporte.burnedCalories
        consumedCaloriesAux = consumedCaloriesAux +reporte.consumedCalories
      end
       diferenceAux = consumedCaloriesAux - burnedCaloriesAux
        if diferenceAux > 0
          typeAux = 'Caloric Surplus'
        elsif diferenceAux <0
          typeAux = 'Caloric Deficit'
        else
          typeAux = 'Balance'
        end
      report = Report.new(burnedCalories: burnedCaloriesAux, consumedCalories: consumedCaloriesAux,creation_date:date, diference: diferenceAux, diference_value: typeAux)
      @finalReports.unshift(report)
    end
    @finalReports = @finalReports.paginate(page: params[:page], per_page: 10)
   # @finalReports = @finalReports.paginate(page: params[:page], per_page: 10)
   #@finalReports = User.page(params[:page])
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)
     @report.owner_id = current_user.id
    @report.creation_date = Date.today
    @report.diference = (@report.consumedCalories - @report.burnedCalories) 
    if @report.diference > 0
      @report.diference_value = 'Caloric Surplus'
    elsif @report.diference <0
      @report.diference_value = 'Caloric Deficit'
    else
      @report.diference_value = 'Balance'
    end

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: "Report was successfully created." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end
  
   def list_by_date
     date =Date.parse(params["format"])
    @reports = Report.where('creation_date = ?', date).where('owner_id = ?', current_user.id)
    @reports = @reports.paginate(page: params[:page], per_page: 5)
   # @reports = Report.page(params[:page])
    
    
  end
  
  def filter_date
    puts "Start es #{params[:start]}"
    puts "End es #{params[:end]}"
    @start_date = params[:start].try(:to_date) || 30.days.ago.to_date
    @end_date = params[:end].try(:to_date) || Date.current
    range = (@start_date..@end_date)
    @filterReport = Report.where('owner_id = ?', current_user.id).where(creation_date: range)
  end
  
  def graphic
    date =Date.parse(params["format"])
    @reports = Report.where('owner_id = ?', current_user.id)
    
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:consumedCalories, :burnedCalories, :diference, :diference_value, :creation_date)
    end
end
