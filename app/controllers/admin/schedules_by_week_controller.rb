class Admin::SchedulesByWeekController <  Admin::ApplicationController
  def show
    @schedules = Schedule.where(set_conditions(:id))
    render json: @schedules
  end

  def create
    from_week = get_beginning_of_week(params[:from_week])
    to_week = get_beginning_of_week(params[:to_week])

    render_params_error("params 'from_week' and 'to_week' must be given as as '%y-%m-%d', and shouldn\'t be  the same week!") and return  if from_week.blank? || to_week.blank? || from_week == to_week

    render_conflict_error("target week already have schedules, please delete them all and try again!!")  and return if creation_conflict?

    render_not_found_error("Can't find any schedules in from_week!!") and return if Schedule.where(set_conditions(:from_week)).size == 0

    render json: do_copy(from_week, to_week)
  end

  def destroy
    target_week = get_beginning_of_week(params[:id])

    render_params_error("id must be given as %y-%m-%d!!") and return  if target_week.blank?

    render_conflict_error("some schedules of this week have already created trainings, can't be deleted!!") and return if destroy_conflict?

    target_list = Schedule.where(set_conditions(:id))

    render_not_found_error("Can't find any schedules in the giving week, nothing can be delete!") and return if target_list.size == 0

    do_destry(target_list)

  end

  private
  def render_not_found_error(msg)
    error_container = Schedule.new
    error_container.errors.add("schedules", msg)
    render_error error_container, :not_found
  end

  def do_destry(scd_list)
    scd_list.each do |scd|
     begin
      scd.destroy!
     rescue RecordNotDestroyed
      render_error scd, :unprocessable_entity
     end
    end
  end

  def destroy_conflict?
    Schedule.joins(:trainings).where(set_conditions(:id)).count > 0
  end

  def creation_conflict?
    Schedule.where(set_conditions(:to_week)).size > 0
  end

  def render_conflict_error(msg)
    error_container = Schedule.new
    error_container.errors.add("schedules", msg)
    render_error error_container, :conflict
  end

  def do_copy(from_week, to_week)
    gap =  to_week - from_week
    from_list = Schedule.where(set_conditions(:from_week))
    new_list = []
    from_list.each do |scd|
      new_scd = scd.dup
      new_scd.start_time += gap.days
      new_scd.end_time += gap.days
      new_scd.save!
      new_list << new_scd
    end
    return new_list
  end

  def render_params_error(msg)
    error_container = Schedule.new
    error_container.errors.add("schedules", msg)
    render_error error_container, :unprocessable_entity
  end

  def get_beginning_of_week(param)
    return nil unless params.present?
    begin
     return Date.parse(param).beginning_of_week
    rescue ArgumentError
      return nil
    end
  end


  def set_conditions(param_symbol)
    condition = init_condition
    condition = add_store_filter_condition(condition)

    if params[param_symbol].present? && params_day = Date.parse(params[param_symbol])
      begin_date = params_day.beginning_of_week
      end_date =params_day.end_of_week
      qstring_clause = "And date(start_time) >= ? And date(start_time) <= ? "
      qstring_options = [ begin_date,end_date ]
      condition = add_params_condition(condition, params[param_symbol], qstring_clause, qstring_options)
    end
    condition
  end
end
