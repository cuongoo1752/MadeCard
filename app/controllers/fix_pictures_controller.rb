class FixPicturesController < ApplicationController
  include UsersHelper
  before_action :set_fix_picture, only: %i[show edit update destroy]

  def index
    @fix_pictures = FixPicture.where(status: 1).order(created_at: :asc)
  end

  def list_image
    @fix_pictures = FixPicture.where(status: 1).order(created_at: :asc)
    @chunked_fix_pictures = @fix_pictures.each_slice((@fix_pictures.length / 4.0).ceil).to_a
  end

  def new
    @fix_picture = FixPicture.new
  end

  def edit; end

  def create
    @fix_picture = FixPicture.new(fix_picture_params.merge(
                                    {
                                      user_id: current_user.id,
                                      status: 1
                                    }
                                  ))

    if @fix_picture.save
      redirect_to fix_pictures_url, notice: 'Ảnh đã tạo thành công!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @fix_picture.update(fix_picture_params.merge(
                             {
                               user_id: current_user.id,
                               status: 1
                             }
                           ))
      redirect_to fix_pictures_url, notice: 'Ảnh đã cập nhật thành công!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fix_picture.update(delete_params)

    redirect_to fix_pictures_url, notice: 'Ảnh đã xóa thành công!'
  end

  private

  def set_fix_picture
    @fix_picture = FixPicture.find(params[:id])
  end

  def fix_picture_params
    params.require(:fix_picture).permit(:title, :user_id, :picture)
  end
end
