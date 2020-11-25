#!/usr/bin/ruby
count = 1
done = false
while not done
  file_name = "info#{count}"
  if File.exist?(file_name)
    puts File.read(file_name)
    count = count + 1
    File.delete(file_name)
  else
    done = true
  end
end

puts " "
puts "out.txt"
puts "-------"
if File.exist?("out.txt")
  puts File.read("out.txt")
end
