class Training < ApplicationRecord
  belongs_to :customer
  belongs_to :schedule
  enum booking_status:{
    no_booking: -1,
    booked: 0,
    waiting: 1,
    waiting_confirmed: 2,
    cancelled: 3
  }

  enum training_status: {
    not_start: 0,
    absence: 1,
    be_late: 2,
    complete: 3
  }
end
