class PrintersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
	def index
	end

	def new
		@printer = current_user.printers.build
	end
  def create
   	@printer = current_user.printers.build(printer_params)
    @printer.active ||= "true"
    @printer.kwh = 0.6
    @printer.desgaste = Modelo.find_by(name: @printer.modelo).desgaste
    @printer.materials.each do |material|
      material.potencia = Mat.find_by(name: material.name).potencia
      material.densidade = Mat.find_by(name: material.name).densidade
    end

   	if @printer.save
     	flash[:success] = "Impressora Adicionada!"
     	redirect_to galeria_path
    else
     	flash[:alert] = "Sua Impressora nao pôde ser adicionada!  Por favor, cheque o formulário."
     	render :new
      end
  end

  def edit
    @printer = Printer.find(params[:id])
  end

  def update
    @printer = Printer.find(params[:id])
    @printer.update(printer_params)
    redirect_to(:back)
  end
  def destroy
    @printer = Printer.find(params[:id])
    if @printer.user.id == current_user.id
      @printer.delete
      respond_to do |format|
        format.html {redirect_to profile_path(@printer.user.user_name)}
        format.js
      end
    end
  end
  def active
    @printer = Printer.find(params[:id])
    @printer.update_attribute(:active, "true")
    respond_to do |format|
      format.html {redirect_to profile_path(@printer.user.user_name)}
      format.js
    end
  end

  def deactive
    @printer = Printer.find(params[:id])
    @printer.update_attribute(:active, "false")
    respond_to do |format|
      format.html {redirect_to profile_path(@printer.user.user_name)}
      format.js
    end
  end




  private
  def set_user
    if current_user.tipo != 'admin'
      redirect_to galeria_path
    end
  end
  def printer_params
    params.require(:printer).permit(:name,:marca, :modelo, materials_attributes: [:id, :name, :preco, {color_ids:[]},:_destroy])
  end
end
