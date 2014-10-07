class Admin::StaffsController < ApplicationController
  def index
    @staff = Staff.all
  end

  def new
    @staff = Staff.new
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      flash[:success] = 'Staff member added. You may now crop the image.'
      redirect_to crop_admin_staff_path(@staff)
    else
      render :new
    end
  end

  def crop
    @staff = Staff.find(params[:id])
  end

  def edit
    @staff = Staff.find(params[:id])
  end

  def update
    @staff = Staff.find(params[:id])

    if @staff.update(staff_params)
      if @staff.cropping?
        for attribute in ['crop_x', 'crop_y', 'crop_w', 'crop_h']
          @staff.send(attribute + '=', staff_params[attribute])
        end
        @staff.crop if @staff.cropping?
      end

      if @staff.save
        flash[:success] = 'Staff member\'s information was updated.'
        redirect_to admin_staffs_path
      else
        flash[:error] = 'Failed to update the staff member\'s information.'
        render :edit
      end
    end
  end

  def destroy
    @staff = Staff.find(params[:id])
    @staff.destroy
    redirect_to admin_staffs_path
  end

  private

  def staff_params
    params.require(:staff).permit(:image, :name, :position, :description, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
