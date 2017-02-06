class Team < ActiveRecord::Base
    has_many :participants

    validates :category, :presence => true
    validates :category, :uniqueness => true
end
