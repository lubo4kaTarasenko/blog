module Validators
  class DepthValidator < ActiveModel::Validator
    def validate(record)
      if record.depth > 4
        record.errors.add :depth, "too deep"
      end
    end
  end
end