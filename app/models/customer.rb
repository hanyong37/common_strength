class Customer < ApplicationRecord
  validates :name, :mobile, presence: true, uniqueness: true
  validates :membership_type, presence: :true

  has_many :trainings, dependent: :restrict_with_error
  has_many :operations, dependent: :delete_all
  has_many :schedules, through: :trainings, dependent: :restrict_with_error
  belongs_to :store

  has_secure_token

  scope :by_store, ->(param) {where(store_id: param) if param.present? }
  scope :by_locked, ->(param) {where(is_locked: param) unless param.nil? }

  enum membership_type: {
    time_card: 1,
    measured_card: 2
  }

  def show_status
    if is_locked
      '已锁定'
    elsif measured_card? && membership_remaining_times < 1
      '无次数'
    elsif time_card? && membership_duedate < Date.today
      '已逾期'
    else
      '正常'
    end
  end

  def store_name
    self.store.name
  end

  def membership_remaining_times
    return 0 if time_card?
    membership_total_times - trainings.valid_booking.size + trainings.absence.size
  end

  def is_weixin_connected
    return weixin.present?
  end

  def booked_number
    trainings.valid_booking.size
  end

  def booked_and_not_started_number
    trainings.valid_booking.not_started.size
  end

  def booked_and_complete_number
    trainings.valid_booking.attended.finished.size
  end

  def booked_and_be_late_number
    trainings.valid_booking.finished.be_late.size
  end

  def booked_and_absence_number
    trainings.valid_booking.finished.absence.size
  end
  #  def favorite_time_slots
  #    trainings.unscoped.joins(:schedule).group('to_char(schedules.start_time, \'HH24:mm\') || \'~\' ||to_char(schedules.end_time, \'HH24:mm\')').count.sort_by{|k,v| v}.reverse.take(3).map{|e| e.join(',')}.join(' ')
  #    #trainings.uniq(:course_name)
  #  end
  #
  #  def favarite_courses
  #    trainings.unscoped.joins(:schedule).group('schedules.course_id').count.sort_by{|id, count| count}.reverse.take(3).map{|e| "#{Course.find(e[0]).name}:#{e[1]}"}.join(',')
  #  end
  #

end
