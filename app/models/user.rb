class User < ActiveRecord::Base
    has_many :wikis
    has_many :collaborators
    has_many :collaborated_wikis, through: :collaborators, source: :wiki
    enum role: [:standard, :premium, :admin]
    
    after_initialize :check_role
    
    def check_role
       self.role ||= :standard           
     end
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
