require_relative "getFiles.rb"

getManyFiles(["defs","classes"])

$game = {
    :enemies => [],
    :enemyNames => ["Tright", "Squall", "Pex   ", "Herth "],
    :focusNames => ["Ana", "Lai", "Pem"]
}
$player = {
    :name => "Yakov",
    :mhp => 20,
    :chp => 20,
    :malp => 12,
    :base => [4, 4, 4],
    :atk => [0, 0, 0],
    :def => [0, 0, 0]
}

def battle(seed = 0)

    if seed == 0
        $game[:enemies].push(Enemy.new)
        $game[:enemies].push(Enemy.new)
    end

    loop do

        system("cls")

        puts "Enemy Stats\n "
        temp = 0
        $game[:enemies].each do |enemy|
            print "  [#{" " * (1 - temp.to_s.length)}#{temp}] "
            print "#{enemy.stats[:name]} Lv#{enemy.stats[:lv]} | "
            print "Rigidness: #{enemy.stats[:chp]} / #{enemy.stats[:mhp]} | "
            print  "Focus: #{enemy.stats[:base]} #{$game[:focusNames][enemy.stats[:focus]]} "
            puts ""
            temp += 1
        end
        puts "\n\n"

        if $player[:name].end_with?("s")
            print "#{$player[:name]}' "
        else
            print "#{$player[:name]}'s "
        end
        puts "Stats"
        puts "  Vitality: #{$player[:chp]} / #{$player[:mhp]}"
        puts "  Focus | Bse | Atk | Def | Max Focus: #{$player[:malp]}"
       #puts "   ###  | ### | ### | ###"
        3.times do |z|
            print "   #{$game[:focusNames][z]}  | "
            print "#{" " * (3 - $player[:base][z].to_s.length)}#{$player[:base][z]} | "
            print "#{" " * (3 - ($player[:base][z] + $player[:atk][z]).to_s.length)}#{$player[:base][z] + $player[:atk][z]} | "
            print "#{" " * (3 - ($player[:base][z] + $player[:def][z]).to_s.length)}#{$player[:base][z] + $player[:def][z]} |"
            puts ""
        end
        puts "\nActions\n"
        puts "  [B] Balance Focus"
        puts "  [S] Focus Strike"
        puts "  [F] Flee"
        print "\n[ ACT ]> "
        action = gets.chomp.split(" ")

        if action.count == 1
            if action[0].downcase == "b"
                puts "\nHow to use [B] Balance Focus:"
                puts "Type \"B\" followed by three numbers all seperated by spaces."
                puts "The first number will set Ana focus, the second will set Lai focus and the third will set Pem focus."
                temp = rand(0..$player[:malp])
                temp2 = rand(0..$player[:malp] - temp)
                temp3 = $player[:malp] - (temp + temp2)
                puts "Example: \n[ ACT ]> B #{temp} #{temp2} #{temp3}"
                puts "\nNOTE: The value of all three numbers cannot be more or less than your maximum focus"
                sleep(0.2)
                print "\n[NEXT?]> "
                gets.chomp
            else
                puts "\"#{action[0]}\" is not a valid action (please type the letter tag in [] to choose actions)."
                print "\n[NEXT?]> "
                gets.chomp
            end
        elsif action.count > 1
            if action[0].downcase == "b"
            else
                puts "\"#{action.join(" ")}\" is not a valid action (please type the letter tag in [] to choose actions)."
                print "\n[NEXT?]> "
                gets.chomp
            end
        end

    end

end

class Enemy

    attr_accessor :stats

    def initialize(type = 0)
        @stats = {
            :type => type,
            :name => $game[:enemyNames][type],
            :mhp => 6,
            :chp => 6,
            :lv => 1,
            :focus => rand(0..2),
            :base => 6
        }

    end

end

loop do

    system("cls")
    print "Battle?\n[-----]> "
    a = gets.chomp.downcase
    if a == "no"
        break
    elsif a == "yes"
        battle
    end

end