class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings

  scope :both_title_status, -> title, status { where('title like?', "%#{title}%").where('status like?', "#{status}") }
  scope :only_title, -> title { where('title like?', "%#{title}%")}
  scope :only_status, -> status { where('status like?', "#{status}")}

  enum priority:{
    高: 0,
    中: 1,
    低: 2,
  }
end
