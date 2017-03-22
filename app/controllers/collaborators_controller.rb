class CollaboratorsController < ApplicationController
    def update
        @wiki.collaborator = params[:wiki][:collaborator]
    end

    def create
        @wiki = Wiki.find(params[:wiki_id])
        @collaborator = @wiki.collaborators.build(user_id: params[:user_id])

        if @collaborator.save
            flash[:notice] = 'Collaborator was added successfully.'
            redirect_to edit_wiki_path(@wiki)
        else
            flash[:alert] = 'Collaborator was not added.  Please try again.'
            redirect_to edit_wiki_path(@wiki)
        end
    end

    def destroy
        @collaborator = Collaborator.find_by_user_id_and_wiki_id(params[:user_id], params[:wiki_id])

        if @collaborator.destroy
            flash[:notice] = 'Collaborator was removed successfully.'
            redirect_to edit_wiki_path(params[:wiki_id])
        else
            flash[:alert] = 'Collaborator was not removed.  Please try again.'
            redirect_to edit_wiki_path(params[:wiki_id])
        end
    end
end
