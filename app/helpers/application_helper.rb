module ApplicationHelper
  def page_header(text)
    content_for(:page_header) { text.to_s }
  end

  def gravatar_for(user, size = 30, title = user.name)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_image_url(user.email, size: size, alt: user.name), title: title, class: 'img-rounded'
  end
end
