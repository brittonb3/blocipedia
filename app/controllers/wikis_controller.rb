class WikisController < ApplicationController
  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]

    if @wiki.save
      flash[:notice] = "Wiki was successfully saved."
      redirect_to root_path
    else
      flash[:alert] = "Error creating Wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @users = User.all
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.private = params[:wiki][:private]
    @wiki.collaborators.delete_all
    if @wiki.save
      if params[:collaborator_ids]
        params[:collaborator_ids].each do |collab_id|
          Collaborator.create({user_id: collab_id, wiki_id: params[:id]})
        end
      end
      flash[:notice] = "Wiki was successfully updated."
      redirect_to @wiki
    else
      flash[:alert] = "Error editing wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was successfully deleted."
      redirect_to wikis_path
    else
      flash[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

end
