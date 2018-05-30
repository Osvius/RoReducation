module EmailValidatable
  extend ActiveSupport::Concern

  class EmailValidation < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      begin
        x = Mail::Address.new(value)
      rescue Mail::Field::ParseError
        record.errors[attribute] << (options[:message] || "is not a valid email")
      end
    end
  end
end