class Post < ApplicationRecord
    validates :url , {presence: true}
    validates :title , {presence: true}
    validates :summary , {presence: true}
    validates :keyword , {presence: true}
end
