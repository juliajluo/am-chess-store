class SchoolsController < ApplicationController
  def index
    @schools = School.alphabetical.paginate(:page => params[:page]).per_page(10)
  end
  #
  def new
    @schools = School.new
  end
  #
  def create
    @schools = School.new(school_params)
    if @schools.save
      redirect_to edit_user_path(current_user), notice: "Created #{@school.name}"
    else
      render action: 'new'
    end
  end

  private
  def school_params
    params.require(:school).permit(:name, :street_1, :street_2,:city, :state, :zip, :min_grade, :max_grade)
  end

end
