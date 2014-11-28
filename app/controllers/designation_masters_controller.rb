class DesignationMastersController < ApplicationController
  authorize_resource
  
  def map
    page = params[:page].present? ? params[:page] : 1
    @designations = DesignationMaster.updated_at.all.paginate(:page => page, :per_page => 30)
    respond_to do |format|
      format.json do
        data = {}
        designations = @designations.map do |var|
          if Role.find_by_id(var.managed_by).present?
            { id: var.id, name: var.name , managed_by: Role.find_by_id(var.managed_by).role}
          else
            
            { id: var.id, name: var.name , managed_by: "Need to be Mapped"}
          end
        end
        data[:designations] = designations
        render :json => JsonPagination.inject_pagination_entries(@designations , data)
      end
      format.html do
        redirect_to designation_masters_path
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
        redirect_to designation_masters_path
      end
    end
  end

  def designation_params(params)
    params.permit(:name , :managed_by)
  end
  
  
end
