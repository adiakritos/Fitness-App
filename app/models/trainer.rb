class Trainer < ActiveRecord::Base

  has_many :clients

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   def active_clients
     clients.where(status: true)
   end

   def inactive_clients
     clients.where(status: false)
   end

   def get_client_name(id)
     firstname = clients.where(id: id)[0].firstname
     lastname  = clients.where(id: id)[0].lastname
     return firstname + " " + lastname
   end

   def current_client
     clients.where(id: session[:current_client])
   end
end
