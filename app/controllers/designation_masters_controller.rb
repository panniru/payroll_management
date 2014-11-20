class DesignationMastersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end
  
  def update
  end
  def new
  end


  def designation_params
    designation_params = params.require(:designation_master).permit(:name, )
    
  end
end
