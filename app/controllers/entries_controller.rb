class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :finish_userinfo
  def create
      if Entry.where(user_id: current_user.id, course_id: entry_params[:course_id]).empty?
        Entry.create(user_id: current_user.id, course_id: entry_params[:course_id])
        redirect_to mypage_path
      end
  end
  def destroy
  end
  private
  def entry_params
    params.require(:entry).permit(:course_id)
  end
end
