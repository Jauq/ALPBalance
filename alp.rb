require_relative "getFiles.rb"

getManyFiles(["classes"])

$game = Game.new
$v = "Ome 0.2"

loop do

  $game.clearScreen
  $game.clearActions

  if $game.menu == "main"
    puts "ALP Balance"
    puts "Version #{$v}"
    if $game.continue != "main"
      $game.newAction("Continue", $game.continue)
    end
    $game.newAction("New Game", "ng")
    $game.newAction("Load Game", "lg")
    $game.newAction("Quit", "quit")

  elsif $game.menu == "quit"
    puts "Are you sure you want to quit?"
    $game.newAction("No", "main")
    $game.newAction("Yes", "quit2")

  elsif $game.menu == "quit2"
    break

  elsif $game.menu == "ng"
    $game.player = Player.new
    puts "What is your name?"
    print "\n>> "
    $game.player.name = gets.chomp
    if $game.player.name == ""
      puts "\nSurely your name is not nothing."
    else
      puts "\nHello #{$game.player.name} it is nice to meet you."
      $game.newAction("Hello.", "intro")
      $game.newAction("Wait. That isn't my name.", "ng")
    end

  elsif $game.menu == "lg"
    puts "This is currently not implemented."
    $game.menu = "main"

  elsif $game.menu == "intro"
    $game.menu = "base"
    puts "This is where I'd put my intro..."
    puts "IF I HAD ONE."

  elsif $game.menu == "base"
    puts "#{$game.player.name} is currently at their base of operations."
    $game.continue = "base"
    $game.newAction("Explore a Dungeon", "genDungeon")
    $game.newAction("#{$game.player.name}'s Details", "details")
    $game.newAction("Back to Main Menu", "main")

  end

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
      puts "Invalid Selection."
      print "Press Enter to continue. > "
      gets
    end
  else
    print "Press Enter to continue. > "
    gets
  end

end
