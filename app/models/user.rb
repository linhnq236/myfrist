class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    has_many :microposts
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, length: {maximum: 15}
    validates:email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create },
    uniqueness: { case_sensitive: false }
    has_secure_password
    validates:password, presence: true, length:{minimum: 6}
# Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

     # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token =  User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
      end
        # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
    #   forgets a user
      def forget
        update_attribute(:remember_digest,nil)
      end
      def downcase_email 
         self.email = email.downcase 
      end
      def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
        
      end
      # Activates an account.
  def activate
    update_columns(activated: FILL_IN, activated_at: FILL_IN)
  end
      # Sends activation email.
      def send_activation_email
        UserMailer.account_activation(self).deliver_now
      end

      def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
      end
      def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
      end
end
