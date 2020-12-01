#!/usr/bin/ruby
count = 1
done = false
while not done
  file_name = "log/info#{count}"
  if File.exist?(file_name)
    puts File.read(file_name)
    count = count + 1
  else
    done = true
  end
end

puts " "
puts "out.txt"
puts "-------"
if File.exist?("log/out.txt")
  puts File.read("log/out.txt")
end
