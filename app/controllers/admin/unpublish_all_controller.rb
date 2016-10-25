class Admin::UnpublishAllController < Admin::PublishAllController
  def create
    return unless check_param_or_error
    return unless check_unpublish_conflict
    find_target_list_or_error || do_set_published(@target_list, false)
  end

  private

  def destroy_conflict?
    Schedule.joins(:trainings).where(set_conditions(:schedules_by_week_id)).count > 0
  end

  def check_unpublish_conflict
    render_conflict_error("target schedules already have trainings, can't be unpublished.")  and return false if destroy_conflict?
  end

end
