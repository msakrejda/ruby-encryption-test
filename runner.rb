class Runner
  SCALE_FACTOR = 1_000_000

  def initialize(klass)
    @klass = klass
    @item_ids = []
    @run_id = SecureRandom.uuid
  end

  def self.step(name)
    puts "running step #{name}"
    start_at = Time.now
    @klass.name
    SCALE_FACTOR.times do
      yield
    end
    done_at = Time.now
    puts "completed step #{name}"
    Step.create(run_id: @run_id,
                mode: @klass.name,
                step: name,
                duration: done_at - start_at)
  end

  def run_step(name)
    raise StandardError, "No such step (#{state})" unless self.class.states[state]
    self.instance_eval(&self.class.states[state])
  end

  def run_suite
    clean_up
    step :create do
      @item_ids << @klass.create.uuid
    end

    step :read do
      @klass[@item_ids.sample]
    end

    step :decrypt do
      @klass[@item_ids.sample].decrypt_encrypted
    end

    step :update_unencrypted do
      @klass[@item_ids.sample].update_unencrypted
    end

    step :update_encrypted
      @klass[@item_ids.sample].update_encrypted
    end
  end

  def clean_up
    @klass.truncate
  end
end

