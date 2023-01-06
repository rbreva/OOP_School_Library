require_relative './decorator'

class TrimmerDecorator < Decorator
  def correct_name(name)
    name.capitalize[0..9]
  end
end
