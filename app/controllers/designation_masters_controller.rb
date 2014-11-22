class DesignationMastersController < ApplicationController
  
  def map
    page = params[:page].present? ? params[:page] : 1
    @designations = DesignationMaster.updated_at.paginate(:page => page , :per_page => 4)
    respond_to do |format|
      data = {}
      format.json do
        designations = @designations.map do |var|
          { id: var.id, name: var.name , managed_by: var.managed_by}
        end
        data[:designations] = designations
        render :json => JsonPagination.inject_pagination_entries(@designations , data)
      end
      format.html do
        render "map"
      end
    end
  end

  def save_designation
    respond_to do |format|
      format.json do 
      
        a =  params[:designation_details]
        a.each do |i|
          @temp = DesignationMaster.find(i["id"])
          @temp.name = i["name"]
          @temp.managed_by = i["managed_by"]
          @temp.save
        end
        render :json => true
        #redirect_to designation_masters_path
      end
    end
  end
  
  
  

  def designation_params(params)
    params.permit(:name , :managed_by)
  end
  
  
end
