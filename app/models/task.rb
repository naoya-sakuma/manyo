class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :both_title_status, -> title, status { where('title like?', "%#{title}%").where('status like?', "#{status}") }
  scope :only_title, -> title { where('title like?', "%#{title}%")}
  scope :only_status, -> status { where('status like?', "#{status}")}
end
