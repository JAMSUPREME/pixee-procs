# Adding methods for easily chaining together procs
class Proc
  # Pipes the result of the current proc into the next proc
  def >>(next_proc)
    lambda { |*args|
      result = call(*args)
      next_proc.call(result)
    }
  end

  # Acts as a "map" function for the results of the current proc
  def *(next_proc)
    lambda { |*args|
      result = call(*args)
      result.map { |r| next_proc.call(r) }
    }
  end

  # Prepare the current proc with any additional arguments that should
  # be passed during its creation.
  # You do not need to prepare if your proc takes no arguments aside
  # from the output of the prior proc
  def prepare(*args)
    lambda { |*proc_args|
      proc_args += args
      call(*proc_args)
    }
  end

  # prep to save a few characters
  alias prep prepare
  # pix since maybe a nonsense word is easier to avoid overlap
  # with other concepts
  alias pix prepare
end
