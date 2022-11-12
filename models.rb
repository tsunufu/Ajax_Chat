ActiveRecord::Base.establish_connection

class Comment < ActiveRecord::Base
    belongs_to :users
end

class User < ActiveRecord::Base
    has_secure_password
    has_many :comments
end