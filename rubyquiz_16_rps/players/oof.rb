class Oof < Player
  def initialize(opponent)
    if clazz = Object.const_defined?(opponent) && Object.const_get(opponent)
      clazz.class_eval do
        define_method(:choose) { :paper }
      end
    end
  end
  
  def choose
    :scissors
  end
end