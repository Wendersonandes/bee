class PrintersController < ApplicationController
  before_action :authenticate_user!
	def index
	end

	def new
		@printer = current_user.printers.build
	end
  def create
   	@printer = current_user.printers.build(printer_params)
    @printer.active ||= "true" 

   	if @printer.save
     	flash[:success] = "Impressora Adicionada!"
     	redirect_to posts_path
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
        format.html {redirect_to profile_path(@printer.user.id)}
        format.js
      end
    end
  end
  def active
    @printer = Printer.find(params[:id])
    @printer.update_attribute(:active, "true")
    respond_to do |format|
      format.html {redirect_to profile_path(@printer.user.id)}
      format.js
    end
  end

  def deactive
    @printer = Printer.find(params[:id])
    @printer.update_attribute(:active, "false")
    respond_to do |format|
      format.html {redirect_to profile_path(@printer.user.id)}
      format.js
    end
  end




  private
  def printer_params
    params.require(:printer).permit(:name,:marca, :modelo, materials_attributes: [:id, :name, {color_ids:[]},:_destroy])
  end
end
