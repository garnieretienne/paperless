class SameUserIdsValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    value.each do |associated_record|
      if record.user_id != associated_record.user_id
        record.errors[attribute] = "does not have the same owners"
      end
    end
  end
end
