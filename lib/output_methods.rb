$spaces = lambda { puts '-' * 80 }

def print_info hash, text
  $spaces.call
  puts text.green
  hash.map { |e, a| puts "#{e.to_s.light_blue}: #{a}" }
end

def print_hash_info
  INFO.map do |key, value|
    print_info(value, key.to_s) if ARGV[0..-1].include? key
  end
end

def print_all_info
  INFO.map { |key, value| print_info value, key.to_s }
end

def err_msg text
  puts "#{text}".red
  help
  abort
end

def help
  puts "plan [option] [hash] [key]\n".green +
       "plan -r [hash] [key] = rename hash or key\n".light_blue +
       "plan -a [hash] [key] = add hash or key\n".light_blue +
       "plan -d [hash] [key] = delete hash or key\n".light_blue +
       "plan -h = help info\n".light_blue +
       "plan -r #{HASHES.first} 0 = rename 0 key of #{HASHES.first}\n" +
       "your hashes: #{HASHES.map.to_a}\n" +
       "keys example: 0,1,2,3\n"
end
