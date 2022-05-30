# Include the app folder in the Ruby load path
$LOAD_PATH.unshift File.dirname(__FILE__)
require 'computer'

# Main app class
class App
  # start function
  def start
    print_tenten_begin = 50
    main_begin = 0

    computer = Computer.new(100)

    computer.insert('MULT', nil)

    # computer.set_address(print_tenten_begin).insert("MULT").insert("PRINT").insert("RET")
  end
end

app = App.new
app.start
