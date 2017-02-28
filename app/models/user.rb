class User < ActiveRecord::Base
    has_many :wikis
    enum role: [:standard, :premium, :admin]
    
    after_initialize :init
    
    def init
       self.role  ||= :standard           
     end
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
