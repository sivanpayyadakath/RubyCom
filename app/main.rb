# Include the app folder in the Ruby load path
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'computer'
require 'common/error'

# Main app class
class App
  # start function
  def start
    computer = Computer.new(100)

    load_instructions(computer)

    computer.execute
  end

  # Load some predefined instructions
  def load_instructions(computer)
    print_tenten_begin = 50
    main_begin = 0

    computer.address_set(print_tenten_begin)

    computer.insert('MULT').insert('PRINT').insert('RET')

    computer.address_set(main_begin).insert('PUSH', 1009).insert('PRINT')

    computer.insert('PUSH', 6)

    computer.insert('PUSH', 101).insert('PUSH', 10).insert('CALL', print_tenten_begin)

    computer.insert('STOP')
  end
end

app = App.new
app.start
