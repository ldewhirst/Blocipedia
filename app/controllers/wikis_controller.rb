class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
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
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to [@wiki]
    else
      flash[:error] = "There was an error saving the wiki. Please try again"
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully"
      redirect_to @wiki.topic
    else
      flash[:error] = "There was an error deleting the wiki"
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end


end
