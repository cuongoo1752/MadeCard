class FixFontsController < ApplicationController
  before_action :set_fix_font, only: %i[show edit update destroy]

  def index
    @fix_fonts = FixFont.where(status: 1).order(created_at: :asc)
    load_fake_text
  end

  def new
    @fix_font = FixFont.new
    load_fake_text
  end

  def edit
    load_fake_text
  end

  def create
    @fix_font = FixFont.new(fix_font_params.merge(
                              {
                                user_id: current_user.id,
                                status: 1
                              }
                            ))

    if @fix_font.save
      redirect_to fix_fonts_url, notice: 'Tạo font chữ thành công!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @fix_font.update(fix_font_params.merge(
                          {
                            user_id: current_user.id,
                            status: 1
                          }
                        ))
      redirect_to fix_fonts_url, notice: 'Cập nhật font chữ thành công!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @fix_font.update(status: 9)

    redirect_to fix_fonts_url, notice: 'Xóa font chữ thành công!'
  end

  private

  def set_fix_font
    @fix_font = FixFont.find(params[:id])
  end

  def fix_font_params
    params.require(:fix_font).permit(:title, :user_id, :font, :status)
  end

  def load_fake_text
    @fake_text = FakeText.where(status: 1).first.content
  end
end
