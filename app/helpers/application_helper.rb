module ApplicationHelper

  # returns a date as string formatted to dd-mm-yyyy (31-12-2020) for views
  def date_mask(date)
    date.strftime("%d/%m/%Y") unless date.nil?
  end

  # ONLY WORKS ON VIEWS - NOT FOR CONTROLLERS / PUNDIT POLICIES
  # checks if user role is sender or receiver to help customize views for each role
  def sender?(user)
    user.role == 'Envio' || user.role == 'Cadastro'
  end

  def receiver?(user)
    user.role == 'Recepção'
  end

  # customizes title of each view
  def full_title(page_title = '')
    base_title = 'Sample Hub'
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

end
