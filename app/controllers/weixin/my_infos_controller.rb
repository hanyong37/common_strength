class Weixin::MyInfosController < Weixin::ApplicationController
  def show
    render json: @current_customer,
      fields: { users: [:id,
                        :name,
                        :mobile,
                        :is_weixin_connected,
                        :membership_type,
                        :store_id,
                        :membership_remaining_times,
                        :membership_total_times,
                        :membership_duedate,
                        :store_name,
                        :is_locked,
                        :show_status,
                        :booked_number,
                        :booked_and_not_started_number,
                        :booked_and_complete_number,
                        :booked_and_be_late_number,
                        :booked_and_absence_number ] }
  end
end
