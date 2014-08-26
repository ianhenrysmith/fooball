
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  # omniauth
  field :provider, type: String
  field :uid, type: String

  field :name, type: String
  field :image_url, type: String


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    # access_token.info:
    #   <OmniAuth::AuthHash::InfoHash email="ianhenrysmith@gmail.com" first_name="Ian" image="https://lh4.googleusercontent.com/-lXsIA_0NVf4/AAAAAAAAAAI/AAAAAAAAAAA/85oxmxEOap8/photo.jpg?sz=50" last_name="Smith" name="Ian Smith" urls=#<OmniAuth::AuthHash Google="https://plus.google.com/112630439057536304609">>

    unless user = User.where(email: access_token.info["email"]).first
      pw = Devise.friendly_token[0,20]
      user = User.create(
        name: access_token.info["name"],
        email: access_token.info["email"],
        password: pw,
        password_confirmation: pw,
        image_url: access_token.info["image"]
      )
    end

    user
  end

  def self.for_league(league)
    where(:id.in => league.user_ids)
  end

  def leagues
    League.with_user(self)
  end

  def teams
    Team.for_user(self)
  end

end