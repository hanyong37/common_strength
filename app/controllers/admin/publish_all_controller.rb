class Admin::PublishAllController < Admin::SchedulesByWeekController
  def create
    return unless check_param_or_error
    find_target_list_or_error || do_set_published(@target_list, true)
  end

  private
  def check_param_or_error
    @target_week = get_beginning_of_week(params[:schedules_by_week_id])
    render_params_error("params 'target_week'  must be given as as '%y-%m-%d'") and return  false if @target_week.blank?
    true
  end

  def find_target_list_or_error
    @target_list = Schedule.where(set_conditions(:schedules_by_week_id))

    render_not_found_error("Can't find any schedules in target_week!!") and return false if @target_list.size == 0
  end

  def do_set_published(list, value)
    list.update_all(is_published: value)
  end

end
