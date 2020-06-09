class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).map { |n| verse(n) }.join("\n")
  end

  def verse(number)
    bottle_number = bottles_number_for(number)
    next_bottle_number = bottles_number_for(bottle_number.successor)

    "#{bottle_number} of beer on the wall, ".capitalize +
      "#{bottle_number} of beer.\n" \
      "#{bottle_number.action} " \
      "#{next_bottle_number} of beer on the wall.\n"
  end

  private

  def bottles_number_for(number)
    klass =
      if number.zero?
        BottleNumber0
      else
        BottleNumber
      end

    klass.new(number)
  end
end

class BottleNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def container
    if number == 1
      'bottle'
    else
      'bottles'
    end
  end

  def pronoun
    if number == 1
      'it'
    else
      'one'
    end
  end

  def quantity
    number.to_s
  end

  def action
    if number.zero?
      'Go to the store and buy some more,'
    else
      "Take #{pronoun} down and pass it around,"
    end
  end

  def successor
    if number.zero?
      99
    else
      number - 1
    end
  end

end

class BottleNumber0 < BottleNumber
  def quantity
    'no more'
  end
end
