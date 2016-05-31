class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  has_many :wikis, through: :collaborators
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:standard, :premium, :admin]
  after_initialize :default_role

  private
  def default_role
    self.role ||= :standard
  end
end
