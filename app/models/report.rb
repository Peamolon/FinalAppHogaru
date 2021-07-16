class Report < ApplicationRecord
    belongs_to :owner, class_name: 'User' 
    
    def self.generate_token
        return Devise.friendly_token.first(16)
    end
end
