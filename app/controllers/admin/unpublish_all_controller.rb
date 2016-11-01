class Admin::UnpublishAllController < Admin::PublishAllController
  #OPTIMIZE :change all set_conditions to scope expression;
  def create
    return unless check_param_or_error
    return unless find_target_list_or_error
    return unless check_unpublish_conflict
    do_set_published(false)
  end

  private

  def destroy_conflict?
    Schedule.joins(:trainings).where(set_conditions(:schedules_by_week_id)).count > 0
  end

  def check_unpublish_conflict
    if destroy_conflict?
      render_conflict_error("target schedules already have trainings, can't be unpublished.")  and return false
    end
    return true
  end

end
