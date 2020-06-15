class Bottles
  def song
    verses(99, 0)
  end

  def verses(starting, ending)
    starting.downto(ending).map { |n| verse(n) }.join("\n")
  end

  def verse(number)
    bottle_number = BottleNumber.for(number)

    "#{bottle_number} of beer on the wall, ".capitalize +
      "#{bottle_number} of beer.\n" \
      "#{bottle_number.action} " \
      "#{bottle_number.successor} of beer on the wall.\n"
  end
end

class BottleNumber
  attr_reader :number

  def self.for(number)
    klass = if number.zero?
              BottleNumber0
            elsif number == 1
              BottleNumber1
            elsif number == 6
              BottleNumber6
            elsif (number % 6).zero?
              BottleNumber6s
            else
              BottleNumber
            end

    klass.new(number)
  end

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def container
    'bottles'
  end

  def pronoun
    'one'
  end

  def quantity
    number.to_s
  end

  def action
    "Take #{pronoun} down and pass it around,"
  end

  def successor
    BottleNumber.for(number - 1)
  end

end

class BottleNumber0 < BottleNumber
  def quantity
    'no more'
  end

  def action
    'Go to the store and buy some more,'
  end

  def successor
    BottleNumber.for(99)
  end
end

class BottleNumber1 < BottleNumber
  def pronoun
    'it'
  end

  def container
    'bottle'
  end
end

class BottleNumber6 < BottleNumber
  def quantity
    '1'
  end

  def container
    'six-pack'
  end
end

class BottleNumber6s < BottleNumber
  def quantity
    (number / 6).to_s
  end

  def container
    'six-packs'
  end
end
