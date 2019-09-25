require_relative "getFiles.rb"

getManyFiles(["defs","classes"])

$game = {
    :enemies => [],
    :enemyNames => ["Tright", "Squall", "Pex", "Herth"],
    :focusNames => ["ana", "lai", "pem"],
    :canFlee => true,
    :turn => 0
}
$player = {
    :name => "Yakov",
    :mhp => 20,
    :chp => 20,
    :malp => 12,
    :base => [0, 0, 0],
    :atk => [0, 0, 0],
    :prt => [0, 0, 0],
    :mindsEye => true
}
$player[:namePos] = $player[:name].end_with?("s") ? "#{$player[:name]}'" : "#{$player[:name]}'s"

def battle(seed = 0)

    if seed == 0
        2.times do |z|
            $game[:enemies].push(Enemy.new(0, 1))
        end
    end

    loop do

        system("cls")

        puts "Enemy Stats\n "
        temp = [0, 0, 0, 0]
        temp2 = 0
        $game[:enemies].each do |enemy|
            temp2 = "#{enemy.stats[:name]}".length
            temp[0] = temp2 > temp[0] ? temp2 : temp[0]
            temp2 = enemy.stats[:lv].to_s.length
            temp[1] = temp2 > temp[1] ? temp2 : temp[1]
            temp2 = enemy.stats[:mhp].to_s.length
            temp[2] = temp2 > temp[2] ? temp2 : temp[2]
            temp2 = enemy.stats[:base][enemy.stats[:focus]].to_s.length
            temp[3] = temp2 > temp[3] ? temp2 : temp[3]
        end

        temp2 = 0
        $game[:enemies].each do |enemy|
            print "  [#{" " * ($game[:enemies].count.to_s.length - temp2.to_s.length)}#{temp2}] "
            print "#{enemy.stats[:name]}#{" " * (temp[0] - "#{enemy.stats[:name]}".length)} "
            print "Lv #{" " * (temp[1] - enemy.stats[:lv].to_s.length)}#{enemy.stats[:lv]} | "
            if $player[:mindsEye]
                print "Rigidness: #{" " * (temp[2] - enemy.stats[:chp].to_s.length)}#{enemy.stats[:chp]} / #{" " * (temp[2] - enemy.stats[:mhp].to_s.length)}#{enemy.stats[:mhp]} | "
                print "Focus: #{" " * (temp[3] - enemy.stats[:base][enemy.stats[:focus]].to_s.length)}#{enemy.stats[:base][enemy.stats[:focus]]} #{$game[:focusNames][enemy.stats[:focus]].capitalize}"
            else
                print "Rigidness: #{enemy.stats[:chp] > 0 ? "??" : " 0"} / ?? | "
                print "Focus: ?? #{$game[:focusNames][enemy.stats[:focus]].capitalize}"
            end
            puts ""
            temp2 += 1
        end
        puts "\n\n"

        puts "#{$player[:namePos]} Stats"
        puts "  Vitality: #{$player[:chp]} / #{$player[:mhp]}"
        puts "  Focus | Bse | Atk | Def | Max Focus: #{$player[:malp]}"
       #puts "   ###  | ### | ### | ###"
        3.times do |z|
            print "   #{$game[:focusNames][z].capitalize}  | "
            print "#{" " * (3 - $player[:base][z].to_s.length)}#{$player[:base][z]} | "
            print "#{" " * (3 - ($player[:base][z] + $player[:atk][z]).to_s.length)}#{$player[:base][z] + $player[:atk][z]} | "
            print "#{" " * (3 - ($player[:base][z] + $player[:prt][z]).to_s.length)}#{$player[:base][z] + $player[:prt][z]} |"
            puts ""
        end
        puts "\nActions\n"
        puts "  [B] Balance Focus"
        puts "  [S] Focus Strike"
        puts "  [I] Use Items"
        puts "  [E] Change Limbs"
        $game[:canFlee] ? puts("  [F] Flee") : nil
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
                puts "NOTE: Typing \"B\" followed by the word \"Balance\" will try to evenly balance focus between Ana, Lai and Pem."

            elsif action[0].downcase == "f" and $game[:canFlee]

                puts "\nHow to use [F] Flee:"
                puts "Type \"F\" followed by the word \"Please\"."
                puts "This will allow you to flee from the current battle, but be wary that the enemy will get a single attack in before you escape."
                puts "Example: \n[ ACT ]> F Please"
                puts "\nTIP: If you truly wish to flee then perhaps rebalancing focus first to minimize damage sustained would be a good idea."

            else

                battleActionError(action)

            end
        elsif action.count > 1

            if action[0].downcase == "b"

                if action.count == 2
                    if action[1].downcase == "balance"
                        temp = $player[:malp] % 3
                        $player[:base] = [temp > 0 ? ($player[:malp] / 3).floor + 1 : $player[:malp] / 3, temp > 1 ? ($player[:malp] / 3).floor + 1 : $player[:malp] / 3, ($player[:malp] / 3).floor]
                        puts "#{$player[:namePos]} focus has been rebalanced. Base Ana is now #{$player[:base][0]}. Base Lai is now #{$player[:base][1]}. Base Pem is now #{$player[:base][2]}."
                    else
                        battleActionError(action)
                    end
                elsif action.count >= 4
                    temp = action[1].to_i + action[2].to_i + action[3].to_i
                    if temp == $player[:malp]
                        $player[:base] = [action[1].to_i, action[2].to_i, action[3].to_i]
                        puts "#{$player[:namePos]} focus has been rebalanced. Base Ana is now #{$player[:base][0]}. Base Lai is now #{$player[:base][1]}. Base Pem is now #{$player[:base][2]}."
                        $game[:turn] = 1
                    elsif temp > $player[:malp]
                        puts "The total focus you tried to balance (#{temp}) is more than your maximum focus (#{$player[:malp]})."
                    elsif temp < $player[:malp]
                        puts "The total focus you tried to balance (#{temp}) is less than your maximum focus (#{$player[:malp]})."
                    end
                end

            else

                battleActionError(action)

            end

        end

        sleep(0.2)
        print "\n[NEXT?]> "
        gets.chomp

        if $game[:turn] == 1

        end

    end

end

def battleActionError(action)
    puts "\"#{action.join(" ")}\" is not a valid action (please type the letter tag in [] to choose actions)."
end

class Enemy

    attr_accessor :stats

    def initialize(type = 0, lv = 1)
        @stats = {
            :type => type,
            :name => $game[:enemyNames][type],
            :lv => lv,
            :mhp => 4,
            :chp => 4,
            :base => [4, 4, 4],
            :focus => rand(0..2)
        }

        if @stats[:type] == 0
            @stats[:mhp] = @stats[:lv] * 3 + 3
            @stats[:chp] = @stats[:mhp]
            temp = @stats[:lv] * 2 + 4
            @stats[:base] = [temp, temp, temp]
        end

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