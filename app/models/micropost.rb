class Micropost < ApplicationRecord
    belongs_to :user
    mount_uploader :image, PictureUploader
    default_scope -> { order(created_at: :desc) }
    
    validates:title, length:{maximum:100},uniqueness:true
    validates:content, length:{maximum:5000}

end
