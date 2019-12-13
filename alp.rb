# Requires
require_relative "getFiles.rb"
requireManyRubyFiles(["classes"])

# Pre-Initializations
$game = Game.new
$v = "Ome 0.2"

# Game Loop
loop do

  # Pre-Menu Draw
  $game.clearScreen
  $game.clearActions

  # Menu Draw
  if $game.menu == "main"
    puts "ALP Balance"
    puts "Version #{$v}\n"
    if $game.continue != "main"
      $game.newAction("Continue", $game.continue)
      $game.newAction("New Game", "ngw")
    else
      $game.newAction("New Game", "ng")
    end
    $game.newAction("Load Game", "lg")
    $game.newAction("Quit Game", "quit1")

  elsif $game.menu == "quit1"
    puts "Are you sure you want to quit?"
    $game.newAction("No", "main")
    $game.newAction("Yes", "quit2")

  elsif $game.menu == "quit2"
    break

  elsif $game.menu == "lg"
    $game.menu = "main"
    puts "This function is currently not available."

  elsif $game.menu == "ngw"
    puts "You have a currently running game.\nAre you sure you want to start a new game?"
    $game.newAction("No", "main")
    $game.newAction("Yes", "ng")

  elsif $game.menu == "ng"
    $game.menu = "base"
    puts "Starting new game."

  elsif $game.menu == "base"
    puts "Base is empty."
    $game.setContinue
    $game.newAction("Main Menu", "main")

  else
    puts "An error occured. You landed on a menu that does not exist."
    puts "I am trying to find the '#{$game.menu}' menu."
  end

  # Post-Menu Selections
  puts ""
  n = 0
  $game.actions.each do |action|
    puts "(#{n + 1}) #{action.name}"
    n += 1
  end

  if n > 0
    print "\n>> "
    input = gets.chomp.to_i

    if input > 0 and input <= $game.actions.count
      $game.menu = $game.actions[input - 1].dest
    else
      print "Invalid selection.\nPress 'enter' to continue.\n> "
      gets
    end
  else
    print "Press 'enter' to continue.\n> "
    gets
  end

end
