class WikiPolicy < ApplicationPolicy
    attr_reader :user, :wiki

    def initialize(user, wiki)
        @user = user
        @wiki = wiki
    end

    class Scope < Scope
        def resolve
            if user.admin? || user.premium?
                scope.all
            else
                scope.where(private: false)
            end
        end
   end

    def index?
        scope.where(id: wiki.id).exists?
    end

    def show?
        user.admin? || user.premium? || !wiki.private?
    end

    def create?
        user.admin? || user.premium? || !wiki.private?
    end

    def new?
        create?
    end

    def update?
        user.admin? || user.premium? || !wiki.private?
    end

    def edit?
        update?
    end

    def destroy?
        user.admin? || user.premium? || !wiki.private?
    end

    class Scope
        attr_reader :user, :scope

        def initialize(user, scope)
            @user = user
            @scope = scope
        end

        def resolve
            wikis = []
            if user.role == 'admin'
                wikis = scope.all # if the user is an admin, show them all the wikis
            elsif user.role == 'premium'
                all_wikis = scope.all
                all_wikis.each do |wiki|
                    if !wiki.private? || wiki.user == user || wiki.collaborator.include?(user)
                        wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
                    end
                end
            else # this is the lowly standard user
                all_wikis = scope.all
                wikis = []
                all_wikis.each do |wiki|
                    if !wiki.private? || wiki.collaborator.include?(user)
                        wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
                    end
                end
            end
            wikis # return the wikis array we've built up
        end
     end
end
