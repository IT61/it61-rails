class Event < ActiveRecord::Base
  include PermalinkFor

  permalink_for :permalink_title, as: :pretty
  mount_uploader :title_image, EventTitleImageUploader

  belongs_to :organizer, class_name: 'User'
  has_many :event_participations, dependent: :destroy
  has_many :participants, class_name: 'User', through: :event_participations, source: :user

  validates :title, presence: true
  validates :organizer, presence: true
  validates :place, presence: true
  validates :published_at, presence: true, if: :published?

  scope :ordered_desc, -> { order(started_at: :desc) }
  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }
  scope :upcomming, -> { where('started_at > ?', DateTime.current ) }
  scope :today, -> { started_in(DateTime.current) }
  scope :started_in, -> (datetime) {
    where('started_at > :start and started_at < :end',
          start: datetime.beginning_of_day,
          end: datetime.end_of_day)
  }
  scope :published_at, -> (datetime) {
    where('published_at > :start and published_at < :end',
          start: datetime.beginning_of_day,
          end: datetime.end_of_day)
  }
  scope :not_notified_about, ->{ where(subscribers_notification_send: false) }

  def user_participated?(user)
    user && event_participations.find_by(user_id: user.id)
  end

  def participation_for(user)
    event_participations.find_by(user_id: user.id)
  end

  def past?
    started_at < DateTime.current
  end

  def publish!
    self.toggle :published
    self.published_at = DateTime.current
    save!
  end

  def cancel_publication!
    self.toggle :published
    self.published_at = nil
    save!
  end

  private

  def permalink_title
    [started_at.to_date.to_s, title].join(' ')
  end
end
