class FavoritesController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    want = Want.find(params[:want_id])
    current_user.like(want)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    want = Want.find(params[:want_id])
    current_user.unlike(want)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
