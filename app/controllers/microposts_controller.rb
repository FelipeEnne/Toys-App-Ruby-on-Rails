class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_micropost, only: [:edit, :update, :destroy]

  def index
    @microposts = Micropost.all
  end

  def show
  end

  def new
    @micropost = Micropost.new
  end

  def edit
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)

    if @micropost.save
      redirect_to @micropost, notice: "Micropost was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @micropost.update(micropost_params)
      redirect_to @micropost, notice: "Micropost was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @micropost.destroy
    redirect_to microposts_url, notice: "Micropost was successfully destroyed.", status: :see_other
  end

  private

  def set_micropost
    @micropost = Micropost.find(params[:id])
  end

  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
