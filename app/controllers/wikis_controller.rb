class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user).order_by_recently_created
  end

  def new
    @wiki = Wiki.new(params[:id])
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def create
    @wiki = current_user.wikis.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]

    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:alert] = "There was an error saving your wiki. Please try again!"
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    #binding.pry

    #authorize @wiki
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to [@wiki]
    else
      flash[:error] = "There was an error saving the wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    authorize @wiki
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the wiki"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private, user_ids: [])
  end

  def authorize_user
    unless current_user.admin? || current_user.premium?
      flash[:error] = "You must be a premium member to view this"
      redirect_to root_path
    end
  end
end
