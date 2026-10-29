class JankenGame
  HANDS = ["グー", "チョキ", "パー", "戦わない"]
  DIRS = ["上", "下", "左", "右"]

  def start
    loop do
      # 最初のじゃんけんは「ホイ！」、あいこは「ショ！」にするためのフラグ
      winner = play_janken
      
      # 「戦わない」が選ばれたら終了
      break if winner.nil?
      
      break if play_attimuite_hoi(winner)
    end
  end

  private

  # 入力チェック
  def input_number(max)
    loop do
      print "→ " 
      input = gets.chomp
      if input =~ /\A\d+\z/
        num = input.to_i
        return num if num.between?(0, max)
      end
      puts "0〜#{max} の数字を入力してください。"
    end
  end

  # じゃんけん
  def play_janken
    is_aiko = false

    loop do
      if is_aiko
        puts "あいこで..."
      else
        puts "じゃんけん..."
      end
      
      puts "0(グー)1(チョキ)2(パー)3(戦わない)"
      player = input_number(3)

      if player == 3
        puts "戦わないが選択されました。ゲームを終了します。"
        return nil
      end

      if is_aiko
        puts "ショ！"
      else
        puts "ホイ！"
      end

      computer = rand(0..2)
      puts "----------------"
      puts "あなた：#{HANDS[player]}を出しました"
      puts "相手：#{HANDS[computer]}を出しました"
      puts "----------------"

      if player == computer
        is_aiko = true
        next
      end

      if (player == 0 && computer == 1) || (player == 1 && computer == 2) || (player == 2 && computer == 0)
        return :player
      else
        return :computer
      end
    end
  end

  # あっち向いてホイ
  def play_attimuite_hoi(winner)
    puts "あっち向いて～"
    puts "0(上)1(下)2(左)3(右)"
    player_dir = input_number(3)
    puts "ホイ！"
    puts "----------------"

    computer_dir = rand(0..3)

    if winner == :player
      puts "あなた：#{DIRS[player_dir]}"
      puts "相手：#{DIRS[computer_dir]}"
      
      if player_dir == computer_dir
        puts "----------------"
        puts "あなたの勝ちです！"
        return true
      end
    else
      puts "相手：#{DIRS[computer_dir]}"
      puts "あなた：#{DIRS[player_dir]}"
      
      if player_dir == computer_dir
        puts "----------------"
        puts "あなたの負けです。"
        return true
      end
    end
    
    # 一致しなかった場合は自動で次のループ（じゃんけん...）へ
    return false
  end
end

# ゲーム開始
game = JankenGame.new
game.start
