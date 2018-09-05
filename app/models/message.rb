class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validates :body, presence: true

  scope :by_date, -> { order('created_at ASC, id ASC') }

  def html_id
    "message_" + self.id.to_s
  end

  def self.get_previous(id, date, limit)
    if(id)
      Message.by_date.where("(created_at = :date AND id < :id ) OR created_at < :date",{id: id, date: date}).last(limit)
    else
      Message.by_date.last(limit)
    end
  end
end
