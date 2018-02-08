class CustomerReport
  alias :read_attribute_for_serialization :send

  def self.model_name
    @_model_name ||= ActiveModel::Name.new(self)
  end

  attr_accessor :id,
    :customer_name,
    :store_name,
    :from_date,
    :to_date,
    :count_of_valid_booking,
    :count_of_absence,
    :count_of_complete,
    :count_of_be_late,
    :favorite_time_slots,
    :favarite_courses

  def initialize(customer_id,from_date, to_date)

    return nil if customer_id.blank?
    customer = Customer.find_by_id customer_id
    trainings = customer.trainings.from_date(from_date).to_date(to_date).finished

    @id = customer_id
    @customer_name = customer.name
    @store_name = customer.store_name
    @from_date = from_date
    @to_date = to_date

    @count_of_valid_booking= trainings.valid_booking.size
    @count_of_absence = trainings.valid_booking.absence.size
    @count_of_complete = trainings.valid_booking.attended.size
    @count_of_be_late = trainings.valid_booking.be_late.size

    @favorite_time_slots = trainings.joins(:schedule).by_customer(customer_id)
    .group('to_char(schedules.start_time + interval \'8 hours\', \'HH24:MI\') || \'~\' ||to_char(schedules.end_time + interval \'8 hours\', \'HH24:MI\')')
    .count.sort_by{|k,v| v}
    .reverse.take(3).map{|e| "#{e[0]}(#{e[1]}次)"}.join(' | ')

    @favarite_courses =  trainings.joins(:schedule).by_customer(customer_id).group('schedules.course_id').count.sort_by{|id, count| count}.reverse.take(3).map{|e| "#{Course.find(e[0]).name}(#{e[1]}次)"}.join(' | ')
  end

  def self.all(store_id,from_date, to_date)
    crs = []
    Customer.by_store(store_id).order("convert_to(name,'GBK') asc").each do |cst|
      crs << self.new(cst.id, from_date, to_date)
    end
    crs.reject!{|x| x.count_of_valid_booking < 1 }

    #将按名称排好序的元素按照count_of_complete分堆放好；
    #然后对这些堆进行排序后，
    #最后合并成一个数组
    sorthash = Hash.new {|h,k| h[k]=[]}
    crs.each do |item|
      sorthash[item.count_of_complete] << item
    end
    sorted_crs = []
    sorthash.keys.sort{|a,b| b <=> a}.each{|key| sorthash[key].each{|e| sorted_crs << e}}
    #crs.sort!{|a, b| b.count_of_complete <=> a.count_of_complete }
    return sorted_crs
  end
end
