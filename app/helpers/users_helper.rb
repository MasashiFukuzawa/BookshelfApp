module UsersHelper
  GRAVATAR_URL = "https://secure.gravatar.com/avatar"

  def gravatar_for(user, size = 80)
    image_tag("#{GRAVATAR_URL}/#{Digest::MD5::hexdigest(user.email)}?s=#{size}", alt: user.name)
  end
end
