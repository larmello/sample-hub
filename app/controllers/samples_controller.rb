class SamplesController < ApplicationController
  before_action :set_sample, only: %i[edit update]

  def index
    @samples = policy_scope(Sample).where(batch_id: nil).order(updated_at: :desc)
  end

  def show
    @sample = Sample.find(params[:id])
    authorize @sample
  end

  def new
    @sample = Sample.new
    @patient = Patient.new
    authorize @sample
    @patients = policy_scope(Patient).order(created_at: :desc)
  end

  def create
    @sample = Sample.new
    @sample.patient = Patient.find(params[:patient_id].to_i) if params[:patient_id]
    authorize @sample
    if @sample.save
      redirect_to edit_sample_path(@sample)
    else
      redirect_to new_sample_path
    end
  end

  def edit
    @doctors = policy_scope(Doctor).order(first_name: :asc)
  end

  def update
    # raise
    if sample_params[:collected_at] == ""

      if @sample.update(sample_params)
        # Criar funcao para cadastrar o exame
        redirect_to sample_path(@sample) and return
      else
        flash.alert = "ERRO: Algo impediu a atualização da coleta!"
        render :edit
      end

    elsif sample_params[:collected_at] && sample_params[:quantity]
      if @sample.update(sample_params)
        redirect_to samples_path and return
      else
        flash.alert = "ERRO: Informe Data de Coleta e Quantidade!"
        redirect_to samples_path and return
      end
    end
  end

  private

  def sample_params
    params.require(:sample).permit(:patient_id, :doctor_id, :collected_at, :category, :quantity, :observation, :status)
  end

  def set_sample
    @sample = Sample.find(params[:id])
    authorize @sample
  end

  def set_exam
  end
end
