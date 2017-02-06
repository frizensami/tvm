class Team < ActiveRecord::Base
    has_many :participants

    validates :category, :identifier, :presence => true
    validates :category, :uniqueness => { scope: [:identifier] }
end
