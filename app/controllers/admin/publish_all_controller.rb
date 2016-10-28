class Admin::PublishAllController < Admin::SchedulesByWeekController
  def create
    return unless check_param_or_error
    return unless find_target_list_or_error
    do_set_published(true)
  end

  private

  def check_param_or_error
    target_week = get_beginning_of_week(params[:schedules_by_week_id])

    if target_week.blank?
      render_params_error("params 'target_week'  must be given as as '%y-%m-%d'") and return  false
    end

    return true
  end

  def find_target_list_or_error
    @target_list = Schedule.where(set_conditions(:schedules_by_week_id))

    if @target_list.size == 0
      render_not_found_error("Can't find any schedules in target_week!!")
      false
    else
      true
    end
  end

  def do_set_published(value)
    @target_list.update_all(is_published: value)
  end

end
