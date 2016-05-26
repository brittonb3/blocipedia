class Wiki < ActiveRecord::Base
  belongs_to :user
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  scope :visible_to, -> (user) do
      if user.admin? || user.premium?
        all
      else
        where(private: [false, nil])
      end
    end
 end
