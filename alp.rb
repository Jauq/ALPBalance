require_relative "getFiles.rb"

getManyFiles(["classes"])

$game = Game.new
$v = "Ome 0.1"

loop do

  if $game.menu == "main"
    $game.clearScreen
    puts "ALP Balance"
    puts "Version #{$v}"
    $game.clearActions
    $game.newAction("New Game", "ng")
    $game.newAction("Quit", "quit")
  elsif $game.menu == "quit"
    puts "Are you sure you want to quit?"
    $game.clearActions
    $game.newAction("No", "main")
    $game.newAction("Yes", "quit2")
  elsif $game.menu == "quit2"
    $game.clearScreen
    break
  end

  puts ""
  n = 0
  $game.actions.each do |action|
    puts "(#{n + 1}) #{action.name}"
    n += 1
  end

  print "\n>> "
  input = gets.chomp.to_i

  if input > 0 and input <= $game.actions.count
    $game.menu = $game.actions[input - 1].dest
  else
    puts "Invalid Selection."
    print "Press Enter to continue. >"
    gets
  end

end
