#!/usr/bin/ruby

ZIP_FILE = "./mycode.zip"

if ARGV.length == 0
    puts "Usage: Provide the number of the challenge you want to download"
    exit 1
end

if File.exist?(ZIP_FILE)
    puts "The file #{ZIP_FILE} already exists, removing ..."
    File.delete ZIP_FILE
end

challenge_number = ARGV[0].to_i
puts "Creating a #{ZIP_FILE} file containing challenge #{challenge_number} for you to download"

system("mv problems/yycc.rb ./yycc_temp.rb")
system("cp problems/yycc_term.rb problems/yycc.rb")
system("cd problems; zip -r mycode code#{challenge_number}.rb helpers.rb filequeue.rb yycc.rb")
system("mv problems/mycode.zip .")
system("mv ./yycc_temp.rb problems/yycc.rb")
puts "Done!"