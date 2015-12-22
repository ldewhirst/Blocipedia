class WikisController < ApplicationController

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def new
    @wiki = Wiki.new
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    #unless @wiki.public || user.premium? || user.admin?
    #  flash.now[:alert] = "You must be a premium member to view private wikis"
    #  redirect_to new_session_path
    #end
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
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    authorize @wiki
    if @wiki.save(wiki_params)
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
    params.require(:wiki).permit(:title, :body)
  end

  def authorize_user
    unless current_user.admin? || current_user.premium?
      flash[:error] = "You must be a premium member to view this"
      redirect_to root_path
    end
  end
end
