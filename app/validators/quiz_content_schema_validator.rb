class QuizContentSchemaValidator < ActiveModel::EachValidator
  CONTENT_SCHEMA = Schash::Validator.new do
    {
      questions: array_of(
        question: string,
        answer: string
      )
    }
  end

  def validate_each(record, attribute, value)
    return if value.nil? # we validate presence separately

    hash_validation_errors = CONTENT_SCHEMA.validate(value)
    return if hash_validation_errors.empty?

    add_error(record, attribute)
  rescue StandardError => e
    Rails.logger.error "Error validating #{record.class}##{record.id}:"
    Rails.logger.error "  #{e.message}\n#{e.backtrace.join("\n")}"
    add_error(record, attribute)
  end

  protected

  def add_error(record, attribute)
    record.errors.add(attribute, 'has invalid format')
  end
end
